open util/integer

// Owners of allocated OR blocks can be surgeons or service lines.
abstract sig Owner {}
sig Surgeon extends Owner {}

// Service lines group surgeons (for service-owned blocks).
sig Service extends Owner {
  surgeons: set Surgeon
}

// Scheduling horizon: we keep Day abstract to allow extension.
// By default, we’ll run with exactly one Day in examples.
sig Day {}

// OR resources
sig OR {}

// Global parameters (single instance) for working day window and turnover rules.
one sig Params {
  dayStart, dayEnd: Int,
  turnoverOR, turnoverSurgeon: Int
}

// Blocks reserve time on a specific OR for a Day.
// kind identifies if this is allocated time or open time.
abstract sig BlockKind {}
one sig Allocated, Open extends BlockKind {}

sig Block {
  day: one Day,
  operatingRoom:  one OR,
  kind: one BlockKind,
  owner: lone Owner,    // none iff Open
  start, end: Int
}

// Cases are scheduled inside exactly one Block (hence inherit day and OR).
sig Case {
  inBlock: one Block,
  surgeon: one Surgeon,
  start, end: Int
}

// Convenience functions
fun dayOf[c: Case]: one Day { c.inBlock.day }
fun orOf[c: Case]: one OR { c.inBlock.operatingRoom }

// Generic separation predicate with turnover
pred sepByTurnover(c1, c2: Case, t: Int) {
  c1.end + t <= c2.start or c2.end + t <= c1.start
}

// Parameter well-formedness
fact ParamsWellFormed {
  Params.dayStart < Params.dayEnd
  Params.turnoverOR >= 0
  Params.turnoverSurgeon >= 0
}

// Block well-formedness:
// - strictly positive length, within working window
// - Open blocks have no owner; Allocated blocks have one owner
fact BlocksWellFormed {
  all b: Block {
    b.start < b.end
    b.start >= Params.dayStart
    b.end   <= Params.dayEnd
    (b.kind = Open) iff no b.owner
    (b.kind = Allocated) implies some b.owner
  }
}

// Blocks do not overlap on the same OR and Day.
fact BlocksNonOverlappingPerORAndDay {
  all disj b1, b2: Block |
    b1.day = b2.day and b1.operatingRoom = b2.operatingRoom implies
      (b1.end <= b2.start or b2.end <= b1.start)
}

// Cases well-formedness:
// - strictly positive length (via start < end)
// - entirely contained within their Block interval
fact CasesWellFormed {
  all c: Case {
    c.start < c.end
    c.start >= c.inBlock.start
    c.end   <= c.inBlock.end
  }
}

// OR exclusivity: no overlapping cases in the same OR on the same Day,
// allowing a turnover buffer (Params.turnoverOR).
fact ORExclusivity {
  all disj c1, c2: Case |
    dayOf[c1] = dayOf[c2] and orOf[c1] = orOf[c2] implies
      sepByTurnover[c1, c2, Params.turnoverOR]
}

// Surgeon exclusivity: a surgeon cannot have overlapping cases on the same Day,
// allowing a turnover buffer (Params.turnoverSurgeon).
fact SurgeonExclusivity {
  all disj c1, c2: Case |
    dayOf[c1] = dayOf[c2] and c1.surgeon = c2.surgeon implies
      sepByTurnover[c1, c2, Params.turnoverSurgeon]
}

// Owner constraints for Allocated blocks:
// - If owner is a Surgeon, cases must use that exact Surgeon.
// - If owner is a Service, cases must be done by a Surgeon in that Service.
// - Open blocks have no owner and impose no owner constraint.
fact AllocatedBlockOwnerConstraint {
  all c: Case {
    let b = c.inBlock |
      (b.kind = Allocated and b.owner in Surgeon) implies
        c.surgeon in (b.owner & Surgeon)
      and
      (b.kind = Allocated and b.owner in Service) implies
        c.surgeon in ((b.owner & Service).surgeons)
  }
}

// Simple assertions to check consistency
assert CasesInsideBlocks {
  all c: Case | c.start >= c.inBlock.start and c.end <= c.inBlock.end
}

assert BlocksNonOverlapChecked {
  all disj b1, b2: Block |
    b1.day = b2.day and b1.operatingRoom = b2.operatingRoom implies
      (b1.end <= b2.start or b2.end <= b1.start)
}

assert ORAndSurgeonNoOverlap {
  all disj c1, c2: Case |
    (dayOf[c1] = dayOf[c2] and orOf[c1] = orOf[c2]) implies
      sepByTurnover[c1, c2, Params.turnoverOR]
  and
    (dayOf[c1] = dayOf[c2] and c1.surgeon = c2.surgeon) implies
      sepByTurnover[c1, c2, Params.turnoverSurgeon]
}

// A small example scope to visualize instances.
// Feel free to tweak parameter values and scopes.
pred example {
  // Constrain to one Day for a daily schedule
  #Day = 1

  // Reasonable parameter values for a small integer scope
  Params.dayStart = 0
  Params.dayEnd = 50
  Params.turnoverOR = 1
  Params.turnoverSurgeon = 1

  some OR
  some Surgeon
  some Service
  some Block
  some Case
}

// Run and checks (adjust scopes to find solutions more easily)
run example for 8 but
  exactly 1 Day, 3 OR, 3 Surgeon, 2 Service, 5 Block, 6 Case, 8 Int

check CasesInsideBlocks for 8 but
  exactly 1 Day, 3 OR, 3 Surgeon, 2 Service, 5 Block, 6 Case, 8 Int

check BlocksNonOverlapChecked for 8 but
  exactly 1 Day, 3 OR, 3 Surgeon, 2 Service, 5 Block, 6 Case, 8 Int

check ORAndSurgeonNoOverlap for 8 but
  exactly 1 Day, 3 OR, 3 Surgeon, 2 Service, 5 Block, 6 Case, 8 Int

