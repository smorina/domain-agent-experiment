Operating Room Daily Block Schedule — Domain Model

Scope

Models the daily block scheduling of operating rooms (ORs) for a single hospital site and day.
Includes: ORs, Blocks, Cases, Surgeons, Procedures, Equipment (fixed and mobile), time intervals (timeslots), setup and turnover windows, resource availability, and double-booking prevention.
Excludes: post-op recovery (PACU/ICU), billing systems, anesthesia/nursing staffing rosters, detailed pre-op workflows, cross-day planning.

Ubiquitous Language (Glossary)

Day: a calendar date; times are local to the site.
TimeInterval (Timeslot): [start, end) with start < end (half-open).
Operating Room (OR): a physical room in which surgical cases are performed.
Block: a reserved TimeInterval on a specific OR for an owner (Surgeon or ServiceLine) on a Day.
Surgeon: licensed provider responsible for a Case (primary surgeon).
ServiceLine: specialty/department that may own OR blocks.
Procedure: coded operation with typical durations and equipment requirements.
EquipmentType: kind/category of equipment (e.g., C-arm).
EquipmentUnit: a concrete instance of an EquipmentType (e.g., C-arm #A).
Case: planned surgical case performed by a Surgeon for a Procedure, with estimated setup/procedure/turnover durations and required equipment.
CaseAssignment: placement of a Case into an OR and TimeInterval with reserved resources.
OccupancyInterval: [setupStart, turnoverEnd) reserved in the OR for a Case (includes setup and turnover).
ProcedureInterval: [incisionStart, closeEnd) when the Surgeon is occupied by the Case.
Add-on: a Case inserted outside original plans; may use Unallocated time.

Intrinsic Concepts (Entities and Relationships)

OperatingRoom
id, name
capabilities: set of attributes (e.g., laminar flow, imaging)
fixedEquipment: map EquipmentType -> count (installed in the OR)
dayHours: TimeInterval (e.g., 07:00–19:00)
Surgeon
id, name
serviceLine: ServiceLine
ServiceLine
id, name
EquipmentType
id, name
EquipmentUnit
id, type: EquipmentType
location: OR | Storage
mobility: Fixed | Mobile
Procedure
code, name
defaultDurations: setupM, procedureM, turnoverM
requiredEquipment: map EquipmentType -> quantity
requiredORCapabilities: set
Block
day: Day
orId: OperatingRoom.id
owner: Surgeon | ServiceLine | Unallocated
interval: TimeInterval
Case
id, day: Day
primarySurgeon: Surgeon
procedure: Procedure
priority: Elective | AddOn
durations: setupM, procedureM, turnoverM (may override defaults)
requiredEquipment: optional overrides of Procedure.requiredEquipment
CaseAssignment
caseId: Case.id
orId: OperatingRoom.id
occupancyInterval: TimeInterval = [setupStart, turnoverEnd)
procedureInterval: TimeInterval = [incisionStart, closeEnd)
reservedEquipmentUnits: list of EquipmentUnit.id
Consistency: setupStart < incisionStart < closeEnd < turnoverEnd; durations match intervals
DailySchedule
day: Day
operatingRooms: list of OperatingRoom
blocks: list of Block
cases: list of Case
assignments: list of CaseAssignment

Time and Intervals

Intervals are half-open [start, end) to avoid fencepost overlap issues.
For each CaseAssignment:
setupM = incisionStart - setupStart
procedureM = closeEnd - incisionStart
turnoverM = turnoverEnd - closeEnd
All planned intervals occur within the Day and, unless policy allows otherwise, within the OR’s dayHours.

Processes (Business Workflows)

Prepare Blocks
For each OR, define Blocks across dayHours; Blocks owned by a Surgeon, a ServiceLine, or Unallocated (open time).
Place Cases
For each Case, select OR and procedureInterval; derive occupancyInterval by adding setup and turnover around the procedure; prefer placement within owned Blocks (or Unallocated).
Reserve Equipment
For each CaseAssignment, reserve specific EquipmentUnits to satisfy requiredEquipment; honor fixedEquipment installed per OR; draw from mobile pool when needed.
Validate Schedule
Verify invariants (no double-booking of ORs, surgeons, or equipment; block adherence; interval consistency).
Adjust
Re-sequence cases in an OR; move between ORs; reassign equipment; revalidate invariants.

Rules and Invariants (emphasizing availability, setup/turnover, no double-booking) Let overlap(a, b) denote that TimeIntervals a and b intersect (with half-open semantics).

Resource availability and double-booking prevention

OR non-overlap:
For any OR r and distinct cases c1, c2 assigned to r on the same Day:
not overlap(occ(c1), occ(c2)).
Surgeon non-overlap:
For any Surgeon s and distinct cases c1, c2 with s as primary:
not overlap(proc(c1), proc(c2)).
Surgeon transition buffer:
If proc(c1).end = proc(c2).start in different ORs, then proc(c2).start - proc(c1).end >= minSurgeonTransitM (site parameter).
Equipment capacity:
No EquipmentUnit is reserved by two overlapping cases:
For any EquipmentUnit u and distinct cases c1, c2:
if u ∈ reserved(c1) and u ∈ reserved(c2) then not overlap(occ(c1), occ(c2)).
Capacity-by-type (equivalently):
For each EquipmentType e and any time t, the count of overlapping CaseAssignments whose occ contains t multiplied by their required quantity of e does not exceed total available units of e (fixed in assigned OR + mobile pool).
Fixed equipment feasibility:
If requiredEquipment includes type e that is fixed in the assigned OR, the OR’s fixedEquipment[e] >= required quantity; otherwise fulfill with mobile units.

Setup/turnover protection

The OR’s occupancyInterval includes setup and turnover; disjointness of occupancy intervals ensures setup and turnover time is preserved between cases.
Turnover occurs in the same OR as the procedure for the preceding case.

Block adherence (daily block schedule)

Elective cases:
The procedureInterval is contained within a Block of the assigned OR whose owner is either the Case’s primarySurgeon, that surgeon’s ServiceLine, or Unallocated.
AddOn cases:
May use Unallocated time or owner-approved blocks; still must satisfy all resource invariants.

Boundary/consistency

Intervals are within the OR’s dayHours unless an overrun policy applies; durations are non-negative; intervals are well-ordered (setupStart < incisionStart < closeEnd < turnoverEnd).
Procedure.requiredORCapabilities ⊆ assigned OR.capabilities.

Variability parameters (site-configurable)

minSurgeonTransitM (e.g., 5)
defaultTurnoverM by Procedure or OR policy
dayHours per OR (e.g., 07:00–19:00)
equipment inventory by EquipmentType (counts of fixed vs mobile units)

Assumptions (to confirm)

Exactly one primarySurgeon per Case; assistant surgeons not modeled.
Equipment sterilization/cooldown beyond turnover is not modeled.
Anesthesia and nursing staffing are out of scope for scheduling resources.
Cases do not cross midnight; overtime/overrun handling is out of scope here.

Example (sanity check)

Day: 2025-05-06
ORs: OR-1 (Ortho-capable), OR-2 (ENT-capable)
Blocks:
OR-1: 07:00–15:00 owned by ServiceLine Ortho
OR-2: 07:00–15:00 Unallocated
Cases:
C1: Knee scope by Dr. Lee (Ortho), durations 20/60/20, requires 1 C-arm
C2: Hand repair by Dr. Lee, durations 15/45/15, no special equipment
C3: Sinus surgery by Dr. Kim (ENT), durations 20/90/20, requires 1 Navigation unit
Assignments:
C1 in OR-1: occ 07:00–08:40; proc 07:20–08:20; reserve C‑arm #A
C2 in OR-1: occ 08:40–09:40; proc 08:55–09:40
C3 in OR-2: occ 07:00–09:10; proc 07:20–08:50; reserve Nav #B
Checks:
OR-1 occupancy intervals do not overlap; turnover of 20 min between C1 and C2 is preserved.
Dr. Lee’s procedure intervals do not overlap.
Equipment units are not double-booked.

Appendix A — Machine-readable skeleton (JSON) { "domain": "Hospital OR Daily Block Schedule", "scope": { "includes": ["ORs", "Blocks", "Cases", "Surgeons", "Procedures", "Equipment", "setup", "turnover", "timeslots"], "excludes": ["post-op recovery", "billing", "anesthesia/nursing rosters", "cross-day planning"] }, "parameters": { "minSurgeonTransitM": 5 }, "entities": { "OperatingRoom": { "id": "string", "name": "string", "capabilities": "string[]", "fixedEquipment": "Record<EquipmentType,int>", "dayHours": "TimeInterval" }, "Surgeon": { "id": "string", "name": "string", "serviceLine": "ServiceLine" }, "ServiceLine": { "id": "string", "name": "string" }, "EquipmentType": { "id": "string", "name": "string" }, "EquipmentUnit": { "id": "string", "type": "EquipmentType", "location": "OR|Storage", "mobility": "Fixed|Mobile" }, "Procedure": { "code": "string", "name": "string", "defaultDurations": { "setupM": "int", "procedureM": "int", "turnoverM": "int" }, "requiredEquipment": "Record<EquipmentType,int>", "requiredORCapabilities": "string[]" }, "Block": { "day": "Day", "orId": "OperatingRoom.id", "owner": "Surgeon|ServiceLine|Unallocated", "interval": "TimeInterval" }, "Case": { "id": "string", "day": "Day", "primarySurgeon": "Surgeon", "procedure": "Procedure", "priority": "Elective|AddOn", "durations": { "setupM": "int", "procedureM": "int", "turnoverM": "int" }, "requiredEquipment": "Record<EquipmentType,int>?" }, "CaseAssignment": { "caseId": "Case.id", "orId": "OperatingRoom.id", "occupancyInterval": "TimeInterval", "procedureInterval": "TimeInterval", "reservedEquipmentUnits": "EquipmentUnit.id[]" } }, "valueObjects": { "Day": "YYYY-MM-DD", "TimeInterval": { "start": "HH:MM", "end": "HH:MM" } }, "invariants": [ "ORNonOverlap: For any OR r and distinct cases c1,c2 assigned to r, occ(c1) and occ(c2) do not overlap.", "SurgeonNonOverlap: For any Surgeon s and distinct cases c1,c2 with s primary, proc(c1) and proc(c2) do not overlap.", "SurgeonTransit: Back-to-back procedures in different ORs respect minSurgeonTransitM.", "EquipmentUnitExclusiveUse: No EquipmentUnit is reserved by two overlapping cases.", "FixedEquipmentFeasibility: If a required EquipmentType is fixed in an OR, that OR’s fixedEquipment count covers the requirement; otherwise reserve mobile units.", "BlockAdherence: Elective case procedureInterval lies within a suitable Block (owner is Surgeon, Surgeon.serviceLine, or Unallocated for the assigned OR).", "IntervalConsistency: setupStart < incisionStart < closeEnd < turnoverEnd; durations equal interval differences; intervals within OR.dayHours unless policy allows overrun." ] }

Appendix B — Formal constraints (pseudo-logic)

Sets:
Day, OR, Surgeon, ServiceLine, EquipType, EquipUnit, Case
Functions:
orOf: Case -> OR (partial until assigned)
occ: Case -> TimeInterval (occupancy)
proc: Case -> TimeInterval (procedure)
owns: Block -> (OR × Owner × TimeInterval)
needs: Case × EquipType -> Nat
typeOf: EquipUnit -> EquipType
reserved: Case -> set of EquipUnit
Predicates:
overlap([a,b), [c,d)) ≡ (a < d) ∧ (c < b)
Invariants:
OR non-overlap: ∀ c1≠c2 with orOf(c1)=orOf(c2): ¬overlap(occ(c1), occ(c2))
Surgeon non-overlap: ∀ c1≠c2 with surgeon(c1)=surgeon(c2): ¬overlap(proc(c1), proc(c2))
Equipment exclusivity: ∀ c1≠c2: (reserved(c1) ∩ reserved(c2) ≠ ∅) ⇒ ¬overlap(occ(c1), occ(c2))
Capacity-by-type: ∀ e, t: Σc (t ∈ occ(c)) · needs(c,e) ≤ availableUnits(e)
Block containment (elective): ∀ c elective: ∃ Block b for orOf(c) with owner∈{surgeon(c), serviceLine(surgeon(c)), Unallocated} and proc(c) ⊆ interval(b)
Interval ordering: setupStart < incisionStart < closeEnd < turnoverEnd and durations match interval lengths

