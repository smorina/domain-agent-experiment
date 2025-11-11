This is a very well-defined and detailed task. Before I begin the research, could you confirm if you have any preferred sources (e.g., specific papers, books, or authors besides Dines Bjørner and Eric Evans) that I should prioritize? Also, do you want the final Markdown document to include direct citations (with links or DOIs) for traceability, or should the content be synthesized without inline references?

—

1\. I do not have any other preferred sources, but that doesn't mean there aren't good ones out there. 2\. Citations would be good, referenced at the end of the prompt, so the prompt can be provided to the agent without the citations if needed.

—

# **Domain Modeling and Domain Engineering Overview**

Domain modeling is the practice of understanding and describing the **problem domain** – the part of reality relevant to a software system – in a precise and structured way. It focuses on **“what is” in the real world** (the domain as it exists), rather than what the software or requirements will impose. This forms the foundation for building correct requirements and software, especially in critical, high-assurance systems. Domain engineering refers to the **process and methodology** of creating these domain models (also called domain descriptions). This document outlines key methodologies (notably Dines Bjørner’s *Triptych* approach), other domain modeling paradigms (like Domain-Driven Design and product line engineering), and best practices for constructing domain models. The goal is to guide a coding assistant (the “agent”) in producing rigorous, comprehensive domain models and adapting its approach to the context.

## **The Triptych: Bjørner’s Domain–Requirements–Software Paradigm**

Dines Bjørner emphasizes that **software development should proceed in three stages** – **domain understanding, requirements, and software design**, in that order. This is sometimes called the *Triptych* approach. In his words:

* *“Before software can be designed we must know its requirements. Before requirements can be expressed we must understand the domain.”* .

In other words, **domain engineering comes first**: one must thoroughly **describe the domain (the real-world system)** before writing requirements or designing the software. Bjørner calls this a development *dogma* – understanding the domain is a prerequisite for everything else. Once a *precise description of the domain* is established, **requirements** can be derived (expressing what the *machine* shall do in that domain), and finally the software design can be developed . This layered understanding is crucial for high-assurance systems where mistakes in domain understanding can lead to incorrect requirements and flaws in the final software.

**What is a Domain and a Domain Model?** In Bjørner’s terminology, a *domain* is essentially an **application domain or business domain** – “a universe of discourse, an area of human and societal activity” . A *domain description* (or *domain model*) is a **precise specification of the domain as it currently exists**, without reference to any software or desired system. Bjørner defines a domain description as *“a pair of descriptions: an informal narrative text which describes the domain **as it is**, and a formal, mathematical text which, hand-in-hand with the narrative, formalises this description”* . In short, a domain model usually includes both:

* **Informal**: Natural language explanation (possibly using diagrams or tables) for human understanding, using the language of the domain.

* **Formal**: Mathematical or logic-based specifications (sets, relations, invariants, state machines, etc.) to eliminate ambiguity and allow verification.

The domain description is **indicative**, describing facts of the world with phrases like “is” and “are” – it *“tells what there is”* in the domain . This contrasts with a requirements specification (or *prescription*), which is *putative* (“shall” and “must” – describing what *should* be) . A key principle is that **domain models exclude any requirements or design decisions** – they are *not* about how we want things to be, nor about the software itself, but purely about domain realities.

**Why focus on domain modeling?** In high-assurance systems (such as aviation, railways, medical devices, etc.), a deep understanding of the domain can prevent serious mistakes. Bjørner argues that describing the domain thoroughly (often formally) *before* requirements is a novel but crucial practice . By having a correct domain model, requirements can be grounded in reality, and one can verify that software specifications indeed fulfill the requirements given the domain’s constraints. In fact, other software engineering researchers (e.g. Zave and Jackson) echo this: *“The primary role of domain knowledge in requirements engineering is in supporting refinement of requirements to implementable specifications”* . In other words, **domain knowledge plus a correct specification together ensure the requirements are satisfied** . If the domain model is wrong or incomplete, requirements and software can easily miss the mark. Thus, for any complex or safety-critical project, domain modeling is an indispensable step to bridge real-world understanding and system design.

## **Bjørner’s Domain Engineering Methodology**

Bjørner formalized a process for domain engineering which can guide the agent. The **domain engineering process** consists of several stages (often iterative) :

1. **Stakeholder Identification & Interaction:** Determine who the domain experts and stakeholders are, and engage with them regularly . They are the source of truth for domain facts and will validate the model.

2. **Domain Knowledge Acquisition:** Gather raw information about the domain . This may involve interviews, reading domain manuals or standards, observing existing systems – essentially learning how the domain operates.

3. **Domain Analysis:** Analyze and structure the acquired knowledge . This means finding key concepts, rules, and constraints. It often involves abstracting away extraneous details and generalizing from examples to fundamental truths. (Academic note: Domain analysis in product line engineering similarly involves identifying commonalities and variabilities across a domain’s systems .)

4. **Domain Modeling (Domain Description):** Construct the actual **domain model** artifact . This includes writing the narrative description and formal specifications of the domain. The agent’s core output will often be this model. It should be *complete* (covering what’s relevant) and *consistent*. The modeling might leverage multiple representations – e.g., structured text, math formulas, diagrams – as needed to convey the domain precisely.

5. **Domain Verification:** Rigorously check the model for internal consistency and correctness . If a formal specification is developed, this involves proving invariants or type checking. For example, verify that no contradictions exist and that all definitions are sound. In formal methods, one might discharge proof obligations (e.g., show that a function’s preconditions cover all cases of input type, etc.).

6. **Domain Validation:** Validate the model against reality and stakeholder expectations . This usually means reviewing the model with domain experts: does the description accurately reflect the real-world domain as they know it? The agent should facilitate this, for instance by explaining the model in accessible terms to the user and asking if it matches their understanding. Any discrepancies discovered here require revising the model (iterating back through analysis/modeling).

7. **Domain Theory Formation:** (Optional/Advanced) If needed, extract general **domain theories** . This means formulating general lemmas or theorems about the domain model that can be proven (using the formal part of the model). In highly critical domains or for academic purposes, one might develop a theory that, for example, proves certain safety properties always hold in the domain (independent of any software). A *domain theory* is basically the domain model plus proven properties about it .

These stages are not strictly linear; domain modeling is **iterative**. Often, partial models are built, then expanded or revised as new knowledge comes in. It’s expected that early versions might be incomplete or even slightly inconsistent until refined . The agent should be comfortable with this iterative refinement: it might draft a model, then, upon more questioning or user feedback, update the model.

**Domain Facets (Multiple Viewpoints):** To ensure a comprehensive domain model, Bjørner introduces the idea of modeling **facets** of the domain . Each *facet* is a particular **view or aspect** of the domain. Together, the facets cover the domain from all important angles . Bjørner suggests a finite set of generic facets applicable to most domains:

* **Intrinsics:** The inherent *nature* of the domain – its essential **entities and concepts** and their basic relationships . Intrinsics are those aspects “basic to any other facet” . Essentially, this is the core *static* description of “what there is” in the domain. *Example:* In a railway domain’s intrinsics, the fundamental entities might include tracks, stations, and trains, with properties like a track connecting two stations . (From the passenger’s view: “a railway net consists of lines (tracks) connecting stations, and trains that traverse them” .)

* **Support Technology:** The **devices, tools, or infrastructure** that the domain relies on . These are not part of the domain’s essence, but enable it. *Example:* In a railway, support technology might be signaling systems, communication networks, or electrical power systems that support train operations.

* **Management and Organization:** The **human and organizational structures** in the domain . This facet covers how people or authorities are arranged and how they make decisions in the domain context. *Example:* The railway domain might involve a railway authority, dispatchers, maintenance teams, schedules, and hierarchy of control.

* **Rules and Regulations:** The **policies, laws, and rules** governing the domain . This includes any formal regulations, safety rules, or business policies that constrain behavior. *Example:* Speed limits on tracks, safety protocols, or government railway regulations would fall here. It can also cover domain-specific rules (like “no two trains may occupy the same track segment simultaneously” as a safety rule).

* **Scripts (Licenses and Contracts):** Standardized **procedures or contractual agreements** that play out in the domain . This facet includes things like contracts, licenses, or predefined process scripts. *Example:* In a digital media domain, a *license language* script might define how content can be used . In a business domain, a contract template or a use-case script for a typical workflow could be included.

* **Human Behavior:** The **behavioral aspects of people** in the domain . Not all human actions can be formalized as strict rules; this facet considers how humans behave, including errors, irregular behavior, or cultural practices. *Example:* In railway operations, how train drivers or passengers behave (e.g., passengers boarding slowly, drivers sometimes needing breaks) might influence the domain.

* **Business Processes:** (Often considered as part of intrinsics or its own consideration) The **processes and workflows** that occur in the domain to fulfill certain objectives  . A business process is essentially one or more sequences of activities (often involving multiple roles or entities) that achieve a business goal . *Example:* In a transportation domain, “operating a city bus route” is a business process involving a bus, driver, route schedule, passenger stops, etc. . Bjørner suggests rough-sketching such processes early with stakeholders to capture dynamic behaviors.

By systematically going through these facets, the agent can ensure that the domain model isn’t one-dimensional. For instance, after modeling the core entities (intrinsics), one should consider: have we accounted for relevant rules/regulations? Did we note any supporting tools or systems? What about the organizational context and user behaviors? This facet-based approach leads to **completeness** in the domain description . It’s a checklist of perspectives to cover.

Moreover, Bjørner notes that **no single modeling notation may be best for all facets** . For example, intrinsics might be well-captured with set theory or class diagrams, while business processes might be clearer with sequence diagrams or state machines. The agent should be flexible in using different formalisms or description techniques as appropriate for each facet.

## **Other Approaches to Domain Modeling**

While Bjørner’s approach is rooted in formal methods and is well-suited to high-assurance systems, there are other complementary methodologies. The agent should be aware of these, as different projects may call for different techniques (or a blend of them):

### **Domain-Driven Design (DDD)**

**Domain-Driven Design** (a term popularized by Eric Evans in 2003\) is an approach to software design that places the **domain and its complexity at the center of the design process** . The philosophy of DDD is that the structure and language of software code should **match the business domain** closely, so that the software model *is* essentially a model of the domain.

Key aspects of DDD include:

* **Deep Domain Understanding:** Developers must invest time in learning the domain through **close collaboration with domain experts** . In DDD, much like Bjørner’s view, it’s assumed that *“the heart of software is its ability to solve domain-related problems”* . Therefore, developers and the modeling process should focus on the real-world problems and nuances of the domain, not on technical frameworks. *The design is driven by the domain, not by technology* .

* **Ubiquitous Language:** DDD insists on building a **shared vocabulary** between developers and domain experts . This means the team agrees on consistent names for domain concepts and uses them in all communication *and* in the code. The domain model is expressed in this ubiquitous language. For example, if the domain is library management, everyone agrees on terms like *“Book”, “Copy”, “Loan”, “Member”*, and the classes and methods in code use those exact terms. This practice reduces miscommunication and ensures the code’s intent is clear . The agent should adopt the user’s terminology and maintain consistency – effectively, the agent should **speak the user’s language** when discussing the domain.

* **Entities, Value Objects, and other Building Blocks:** In DDD, the domain model is often implemented as an object-oriented design comprising:

  * **Entities:** Domain objects with a distinct identity that persists over time (e.g., a specific **Bank Account** with account number 123\)  .

  * **Value Objects:** Immutable descriptions or values that don’t have a unique identity (e.g., an **Amount** of money, or a **Date** – many objects can have the same value)  .

  * **Aggregates:** Clusters of entities and value objects bound together by an aggregate root, defining a consistency boundary (e.g., an **Order** aggregate that contains Order Items – operations outside the aggregate cannot violate its invariants).

  * **Domain Services:** Operations that don’t naturally belong to a single entity (e.g., a service to transfer money between two accounts) .

  * **Repositories:** Mechanisms for retrieving/storing aggregates, abstracting the data layer.

* The agent should be aware of these concepts because if the user is following a DDD approach, the domain model output might be expressed in terms of classes (for entities/value objects) and their methods or relationships. For instance, capturing a business rule like “**An account cannot be overdrawn**” could mean in a formal model an invariant on the Account balance, whereas in DDD it might be a rule enforced in a method of the Account entity or a domain service method.

* **Bounded Contexts:** Large domains often get segmented into **bounded contexts**, each with its own unified model and ubiquitous language  . This acknowledges that in complex organizations, a single all-encompassing model becomes unwieldy or ambiguous. The agent should identify if the user’s domain actually consists of multiple sub-domains. For example, an e-commerce system might have a “Sales” context and an “Inventory” context – the term “Product” might mean slightly different things in each. In such cases, the agent would help **split the domain model** and clarify context boundaries, rather than forcing one large model.

DDD is less formal than Bjørner’s approach – it typically doesn’t use mathematical specification. Instead, it results in code-level models (classes, methods) and informal diagrams. However, it is **highly pragmatic** and ensures the model is directly useful for implementation. The agent should leverage DDD when the user is working on an enterprise or complex software with lots of business logic and when close interaction with domain experts (users) is feasible. It would prompt the user for domain rules and examples, and encourage naming and structuring the model following domain concepts (not tech terms). This approach yields a design that is intuitive to stakeholders and developers alike. For instance, if modeling a bank system with DDD, the agent would ensure concepts like *Account, Customer, Transaction* are explicit and might produce a class diagram or description of these objects and their interactions, using the same terms the bank’s staff use.

*Example (DDD Style):* In a **Library Management** domain, a ubiquitous language might include terms like *Book, Copy, Catalog, Member (User), Loan, Reservation* . The domain model would reflect these: e.g., a Book entity with attributes like title and author, a Copy value object representing a physical copy of a book, a User (Member) entity, and a Loan service or entity tying a User and a Copy. Business rules (like “A user can borrow at most 5 books” or “A Reservation can be placed on at most 3 books at a time”) are captured either as invariant logic in these classes or separate service logic. The important point is that the terminology and structure stay true to how librarians and users think about a library, rather than, say, reflecting database tables or generic programming abstractions. If needed, a simple UML class diagram can be drawn to illustrate relationships (e.g., a **User** borrows a **Copy** of a **Book**; a **Reservation** holds a **Book** for a **User**). This ensures clarity and alignment with the real-world domain.

### **Software Product Line Domain Engineering**

In the context of **software product lines (SPL)**, *domain engineering* has a specialized meaning. A software product line is a family of related products that share common features but also have variations. Domain engineering in SPL focuses on **capturing those commonalities and variabilities** so that they can be reused across multiple products. The agent should recognize when the user’s goal is to model a **family of systems** rather than a single system.

Key concepts and practices here:

* **Domain Analysis for SPL:** Similar to general domain analysis, but with emphasis on identifying **features**. A **feature** is a logically cohesive piece of functionality or characteristic that may be present or not in a product. Domain analysis in SPL means defining the **scope of the domain (the product line)**, and producing a **domain model that includes a feature model**  . The feature model explicitly lists:

  * **Common features** – those present in all products (the “commonality”).

  * **Variable features** – those that can differ between products (the “variability”).

  * Relationships and constraints between features (e.g., “Feature A requires Feature B” or “Feature X and Y are mutually exclusive”)  .

* The domain model in SPL often comprises **Feature Diagrams** – a tree of features with variability annotations – and possibly reference **architectural models** that show how features map to components.

* **Domain Design and Implementation:** After analysis, **domain design** creates a **reference architecture** or set of solution assets that realize the feature model  . **Domain implementation** might produce **core assets** like code components, frameworks, or even a code generator or domain-specific language that can be used to rapidly instantiate products in the line  . For example, in a product line of mobile phone software, domain engineering might produce a platform where features like “Bluetooth” or “Camera” are modular, and product engineers can select features to produce a specific phone’s software.

* **The Role of the Domain Model:** In SPL, a good domain model serves as a **knowledge repository**. It captures the essence of the domain in a way that can be referred to for each new product variation. *“A good domain model serves as a reference to resolve ambiguities later in the process, a repository of knowledge about the domain, and a specification to developers of products in the domain.”* . This means the domain model isn’t thrown away; it’s a living document used repeatedly. It might include not only features, but also definitions of domain concepts and how they vary. For instance, an SPL domain model for “Automobile Control Systems” might define concepts like *Engine, Transmission, Brake, Sensor* and features like *Cruise Control* (optional) or *Hybrid Engine Support*, etc. When building a new car’s software, engineers consult this model to understand what features are available and how to integrate them.

* **Feature Modeling Notation:** The agent might represent the feature model in a textual form, e.g., a list or tree structure:

  * Example:

    * **E-Shop** (root feature)

      * *Catalogue* (mandatory)

      * *Payment* (mandatory: choose between **BankTransfer**, **CreditCard**, or both)

      * *Search* (optional)

      * *SecurityPolicy* (mandatory: choose **Standard** or **High**)

        * Constraint: if **CreditCard** is chosen, **HighSecurity** must be chosen  .

* This kind of model shows the configuration space of the domain. The agent should clearly separate the idea of a domain feature model (which is *not* a single product’s requirements, but a superset description). It may output something like a **feature list with annotations** or even a simple boolean logic formula representing feature constraints  .

* **Reuse and Variability Mechanisms:** The domain model can also include **variation points** in processes or architecture. For example, the model might say: “In domain X, a system can use either encryption algorithm A or B” (variability in a support technology facet), or “Product can either support Single-Sign-On or not.” The agent should highlight such options if relevant, often by introducing flags or parameters in the model representation. In formal terms, one could use a parameterized specification or inheritance to represent variability.

In summary, when working with product lines, the agent will focus the domain model on **features and choices**. It will likely produce two levels of output:

1. A generic domain model capturing what is always true for all products (the common domain concepts and rules).

2. A variability model (feature model) capturing what can change between products.

This is valuable for companies wanting to maximize reuse: by referring to the domain model, they ensure each new product’s requirements are consistent and no important domain aspect is forgotten.

### **Conceptual Modeling and Ontologies**

It’s also important to note that **domain modeling doesn’t always require heavy formalism**. In many software projects (especially less critical ones), the domain model might be an informal **conceptual model** – for example, a UML Class Diagram or an Entity-Relationship (ER) diagram that visually represents key domain entities, their attributes, and relationships. These are sometimes called **conceptual models** or **domain object models** . The goal is the same: identify the main concepts in the domain and how they relate.

* **UML/Class Diagrams:** A UML class diagram used as a domain model will typically omit any software-specific details (like methods or UI elements) and instead show the domain-level classes. For instance, a class diagram for a **Hospital domain** might show classes like *Doctor, Patient, Appointment, Treatment*, with associations indicating that “Doctor schedules Appointments” or “Patient undergoes Treatment”. Such a diagram is a form of domain model (often created during analysis in approaches like *Object-Oriented Analysis*).

* **ER Diagrams:** In database design, an ER diagram that models data entities (Customer, Order, Product, etc.) is effectively modeling the domain data. While it’s focused on data structure, it is a reflection of domain understanding (what entities exist and how they connect).

* **Ontologies:** In knowledge representation (e.g., semantic web technologies), a domain model might be an **ontology** – a formal definition of concepts, categories, relationships, and rules using languages like OWL or RDF. This is common when building AI systems or interoperable data schemas. An ontology might declare classes (concepts) and properties and even logical constraints. For example, an ontology for the biomedical domain might formalize that “Every Hospital has Doctors and Patients; every Patient has exactly one medical record; a Surgeon is a subclass of Doctor”, etc. Ontologies are essentially domain models that are machine-interpretable and often allow automated reasoning.

The agent should gauge the **level of formality needed**. If a user just needs to sketch understanding, an informal diagram or structured list of concepts may suffice (and is quicker). If a project requires automated reasoning or is integrating with other systems, using an ontology or a more formal schema could be better.

**When to use what:** A rule of thumb:

* For **safety-critical or mathematically complex domains** (aircraft control, cryptographic protocols, etc.), lean towards **formal methods** (Björner’s style, Z, VDM, Alloy, statecharts with clear semantics). This yields a domain model that can be checked for consistency and used to prove properties.

* For **enterprise software with complex business logic but not life-threatening** (e.g., a retail system, banking software), a **Domain-Driven Design** approach might be ideal: it ensures software reflects the domain well and business experts can validate it, but it doesn’t necessarily prove properties mathematically.

* For **software product lines or highly configurable systems**, focus on **feature modeling and variability** in the domain model, possibly supplemented by some formal notation to ensure no illegal feature combinations.

* For **simple or well-understood domains** where formalization overhead is not justified, use **conceptual modeling** like UML diagrams or straightforward descriptions. The agent should still be precise and avoid ambiguity, but it might do so via clear definitions and perhaps a controlled vocabulary rather than full formal logic.

The agent should also be prepared to **mix techniques**. It’s not unusual to have an informal overview accompanied by some formal definitions of critical properties. For example, one might include a UML diagram of key classes, and then add a few formal invariants in English or OCL (Object Constraint Language) to specify critical rules (like “each Order’s total \= sum of its OrderItems’ totals”). The agent’s knowledge of multiple paradigms means it can offer what best fits the user’s needs and skills.

## **Best Practices for Domain Modeling (Agent Guidelines)**

Bringing together insights from the above approaches, here are **actionable best practices** the agent should follow when assisting in domain modeling:

### **1\. Clearly Define the Domain Scope**

**Start by pinning down the domain’s boundaries.** What is the system or context we are modeling, and what is *outside* that scope? This involves understanding the **purpose** of the intended software and focusing on the relevant portion of reality. The agent should ask clarifying questions to determine scope: e.g., “Are we modeling the entire healthcare system or just patient record management?” or “Should we include payment processing in the e-commerce domain model, or is that handled elsewhere?” By establishing scope, we decide which entities and phenomena to include. This prevents the model from drifting into irrelevant details or missing key aspects. A domain description for a flight control software, for instance, would explicitly state that it covers aircraft, airspace, pilots, ATC procedures, etc., but perhaps not the internal mechanics of the aircraft engine (if that’s out of scope for the software’s purpose). State upfront what the domain model **covers vs. excludes**.

### **2\. Engage with Domain Knowledge and Stakeholders**

The agent should **gather domain facts diligently**. This may come from:

* User-provided documentation or descriptions.

* Interviews or Q\&A with the user (who might be a domain expert or have access to one). The agent shouldn’t shy away from asking domain-specific questions: “Can you walk me through how X is currently done in your domain?” or “What are the different states that Y can be in?”

* Existing standards, glossaries, or regulations in the domain (if available to the agent’s knowledge base).

* Prior domain models if this domain or a similar one has been modeled before.

Throughout the modeling, treat domain knowledge as authoritative. If something is uncertain, **flag it as an assumption and verify**. For example, the agent might say, “Assuming that a *Train* can only be on one *Track* at a time (for safety) – is this correct?” and let the user confirm or correct it.

As noted, domain knowledge is not just nice-to-have; it’s what bridges requirements and correct systems . Thus, the agent should continuously cross-check the model against domain knowledge. If a user describes a fact (e.g., “Patients can be either inpatient or outpatient”), the agent incorporates that as a rule or classification in the model. If the user seems to omit some aspect, the agent might gently prompt: “Do we need to consider X in this domain? For example, in healthcare, do we consider insurance as part of the domain, or is that out of scope?”

### **3\. Use Precise and Unambiguous Language**

**Terminology matters.** The agent must help establish a **clear vocabulary** for the domain. Reuse the user’s terms (Ubiquitous Language principle) and ensure each term has one meaning within the model. If a term is vague or overloaded in common use, explicitly define it in the domain context. For instance, if modeling a bank, the word “customer” might mean an individual with an account. The agent should define *Customer* clearly (and perhaps distinguish it from related terms like *Account Holder* or *User* if necessary).

One technique is to maintain a **glossary** of domain terms as part of the output. This could be a bullet list or table: *“**Account:** an entity representing a bank account, identified by an account number, with a balance.”*, etc. This ensures both the user and the agent use terms consistently.

**Avoid ambiguity:** If writing in natural language, use simple, concrete wording. Prefer “Each Train **is assigned to** exactly one Track at a time” over “Trains **link to** tracks” (the latter could be interpreted in multiple ways). If necessary, use a **controlled natural language** or structured sentences (some projects use tools like Attempto Controlled English for specs) to limit vagueness.

When formal notation is used, ensure to tie it to the narrative. For example: “Let Train be the set of all trains. We introduce a function onTrack: Train \-\> Track meaning onTrack(t) is the track that train *t* is currently on. **Invariant:** ∀t1,t2 in Train, if t1≠t2 then onTrack(t1) ≠ onTrack(t2) – no two different trains are on the same track at the same time (safety rule).” This mixing of a bit of math and explanation makes the model precise but still understandable.

In summary, the agent should strive for **clarity** over cleverness. The model is only useful if it’s unambiguous to those who need to use or review it.

### **4\. Structure the Domain Model Logically**

A well-organized model improves understanding. The agent should break down the domain model into **sections or subsections**, each covering a coherent aspect. Borrowing from Bjørner’s facets and general analysis practice, possible structuring could be:

* **Intrinsic Concepts (Static Structure):** List the fundamental *entities, objects, or concepts* in the domain and their **relationships**. Define each entity’s properties (attributes) and any inherent relationships (associations, composition, inheritance/generalization if applicable). For example, define classes like *Station, Track, Train* and relationships like “Track connects two Stations” . If using formal sets, this might be: Station \= {…}, Track \= {…}, with a relation *connects(Track)* \-\> (Station,Station). Also capture classification hierarchies (e.g., “Surgeon is a kind of Doctor”) here if needed.

* **Static vs. Dynamic Elements:** It can help to distinguish **endurants** (objects that have continuity over time, e.g., physical objects, people, documents) from **perdurants** (events or processes that occur, e.g., a flight, a transaction) as per some ontology theories. Essentially, list *static elements* vs *dynamic behaviors*. This could also be done by separate sections: one for domain *Objects/Entities*, and one for domain *Events/Processes*.

* **Processes / Behaviors:** Describe how things in the domain change or interact over time. This could be narratives of workflows (like the business process examples), state machines for lifecycle of an entity, or simply a description of typical scenarios. For instance, a **Business Process** section might outline “how an order moves from placement to delivery” if modeling an order management domain. If formalizing, one might include state transition diagrams or pre/post conditions of operations. In a **dynamic aspect** section, you could define operations (in algebraic spec style or pseudo-code) that change the state: e.g., an operation for a library domain *borrowBook(user, bookCopy)* with precondition “bookCopy is not already loaned out” and postcondition “bookCopy is now marked as loaned to that user; user’s borrowed count increases by one”.

* **Rules and Constraints:** Having a dedicated section for **domain rules** (or business rules) can be useful. This is where invariants, policies, and regulations are captured. Some rules might have been mentioned alongside entities (like an invariant attached to a class), but it’s good to list them clearly. E.g., “**Rule: No Train may have two drivers at the same time** (a human resources regulation)” or “**Rule: Orders over $1000 require manager approval** (business policy)”.

* **Supporting Systems/Interfaces:** If applicable, describe any **external systems or devices** that interact with the domain. This may overlap with support technology facet. For example, in a hospital domain: “The hospital information system interfaces with an external Pharmacy system for medication orders.” This often sets context for requirements later (interface requirements). Here, we’re just describing that such systems exist and what role they play (but not how to integrate them – that’s for requirements).

* **Organizational & Human Aspects:** Identify the **roles or organizational units** and any domain-relevant hierarchy or responsibility. For instance, list roles like *Patient, Doctor, Nurse, Administrator* in a hospital domain and note their general domain responsibilities (“Doctors can prescribe medications; Nurses administer treatments; Admins manage scheduling” etc.). If there are important organizational processes (like “monthly audits” or “incident reporting procedures”), outline them.

* **Exceptions and Unusual Situations:** Domains often have corner cases or exceptional conditions (like *“if the train breaks down, then…”* or *“if a payment fails, the order is put on hold”*). It’s wise to capture these scenarios as part of the domain description if they are inherent to how the domain operates. They might later inform requirements for error handling. The agent should ask if any such scenarios are relevant and document them.

Using **headings and bullet points** (in a Markdown context) is encouraged to make this structure clear. For example, the agent could produce something like:

\#\#\#\# Entities:  
\- \*\*Station\*\*: a place where trains stop. Each Station has a unique name.  
\- \*\*Train\*\*: ... (attributes, etc)  
\- \*\*Track\*\*: connects two Stations (exactly two, no more, no less).  
  \- \*Invariant:\* A Track is always between two distinct Stations \[oai\_citation:73‡www2.imm.dtu.dk\](http://www2.imm.dtu.dk/\~db/5lectures/domain.pdf\#:\~:text=From%20the%20view%20of%20potential,connects%20exactly%20two%20distinct%20stations).

\#\#\#\# Processes:  
\- \*\*Train Journey\*\*: a sequence of movements where a Train goes from one Station to another along tracks...  
\- \*\*Maintenance\*\*: (describe maintenance process)...

\#\#\#\# Rules:  
\- \*\*Safety Rule:\*\* No two trains may be on the same track segment at the same time (to avoid collisions).  
\- \*\*Regulation:\*\* Every medication (in a pharmacy domain) must have a prescription from a licensed doctor, etc.

Such structure helps both the agent (to not forget areas) and the user (to read and verify logically).

The agent might consider using Bjørner’s facets as high-level sections (Intrinsics, Support Tech, etc., as headings). However, depending on the domain, not all facets are equally important. The structure should be tailored to the domain. For example, in a pure software algorithm domain, “human behavior” might be irrelevant, whereas in a sociotechnical system, it’s crucial.

### **5\. Iterate and Refine the Model**

**Domain modeling is iterative.** The agent should not expect to get the model perfect in one go. Instead, a recommended behavior is:

* Draft an initial model (even if partial) based on the information at hand.

* Present it to the user for feedback: “This is what I have understood so far… \[summary\]. Did I miss anything or get anything wrong?”

* Encourage the user to think of scenarios or examples that can test the model. For instance, “Let’s take an example: in this railway model, can two trains swap tracks? How would that work with our model?” This can expose if something about track occupancy or scheduling was overlooked.

* Incorporate the feedback and extend or adjust the model. Maybe the user clarifies a rule or adds a new entity. The agent then updates the respective section.

This process continues until the model is **satisfactory** (or time runs out, in which case ensure it’s at least approximately correct with noted assumptions). It’s better to catch misunderstandings early in domain modeling than later in coding. So the agent should be somewhat **skeptical of its own model** – always open to the possibility it got something wrong and ready to change it.

For high-assurance domains, this refinement might involve formal verification at each step (e.g., each time we add an invariant, we check consistency). In more informal settings, it might involve example test cases or just stakeholder sign-off. The agent can simulate basic reasoning (“if this rule and that event both exist, is there a contradiction?”) and raise those questions.

### **6\. Validate with Stakeholders (User) & Verify Consistency**

This overlaps with steps 5 and 6 of Bjørner’s process. The agent should **validate the model externally** and **verify it internally**:

* **Validation (External):** After building the model, the agent should essentially ask: *“Does this model correctly reflect the real-world domain as you know it?”* The user or domain expert is the judge of that. The agent can facilitate validation by explaining the model in natural language (since not all stakeholders think in formal specs). If there’s a formal part, also describe it: e.g., “We have a set called Patient representing all patients. We have assumed a patient has exactly one primary doctor – is that true in your hospital?” This invites confirmation or correction. Any discrepancies found must be resolved by changing the model to better fit reality.

* **Verification (Internal):** This means checking the model for logical consistency and completeness. The agent can systematically review:

  * Are all referenced concepts defined? (If the model mentions “track segment” but never defined what a segment is, that’s a gap.)

  * Are there contradictory statements? (E.g., one rule says X must be true, another says X must be false in some scenario.)

  * Do the formal constraints make sense together? (If using math, maybe even attempt a simple sanity check or satisfiability check. If it’s something like Alloy, one could in theory run a solver – but our agent can’t execute external code, so it will rely on logical reasoning or user’s help.)

  * Are there obvious missing pieces given the domain? (For instance, if we modeled Trains and Stations but never modeled a notion of a Schedule or Route in a railway, maybe that’s missing – unless intentionally out of scope.)

  * Check boundary conditions: e.g., does the model allow zero instances of something where in reality that cannot happen? Or does it assume something always exists without justification?

If any potential issue is found, the agent can either fix it (if clear) or highlight it to the user for discussion: “The model currently doesn’t prevent a scenario where a train has no route assigned – is that valid or should we enforce that every train must have an assigned route?” This approach not only improves the model but also demonstrates thoroughness.

For formal models, **type checking and theorem proving** might be applicable. For example, in a Z specification, one would prove that initial state satisfies invariants, or that operations preserve invariants. The agent likely won’t do full proofs due to complexity, but it should at least specify important **invariants** and **intended properties** so that they can be proven if needed. E.g., in the domain theory, list a theorem like “The network is deadlock-free if such-and-such holds” if that’s something one could derive. This is more advanced and often not needed unless we are indeed in a critical system domain.

### **7\. Aim for a Machine-Readable and Reusable Format**

Since the objective is to have a **machine-readable domain model**, the agent’s output should be structured in a way that tools or later processes can consume it. Depending on context, this could mean:

* **Formal Specification Languages:** If the user is comfortable with formal methods or has tooling for them, the agent can produce a model in languages like **Z (Zed)**, **VDM**, **Alloy**, **TLA+**, or **B**. These languages allow one to declare sets, relations, invariants, and operations. For example, a Z specification schema might define state \[ and invariants \] and operations separately. The advantage is such specs can often be checked with tools (type checkers, model checkers). However, they have a learning curve. The agent should include accompanying explanation for each formal part, to help the user understand or modify it.

* **Schema or DSL:** Sometimes a **custom domain-specific language or structured schema** can be used. For instance, a JSON or YAML representation of the domain concepts could be produced, which might later feed into code generation. Example in JSON:

{  
  "entities": {  
    "Station": {"attributes": {"name": "Text"}},  
    "Train": {"attributes": {"id": "Text", "capacity": "Int"}}  
  },  
  "relationships": \[  
    {"name": "TrackConnects", "from": "Station", "to": "Station", "constraints": "from \!= to"}  
  \],  
  "rules": \[  
    "Forall TrackConnects(s1,s2): exists Track entity representing the connection",  
    "No two Train can occupy the same Track at the same time"  
  \]  
}

This is illustrative – the agent would tailor the format to something sensible. The point is to consider producing output that is not just narrative but **structurally parseable**.

* **Code Prototypes:** Sometimes representing the domain model as code (in an OOP language, for example) serves both as documentation and a starting point for implementation. For example, writing class definitions in Python/Java with no business logic but just fields and maybe invariants in comments. This is effectively a skeleton of the software reflecting the domain. If the user is a developer, this might be very useful. The agent might do something like:

class Station:  
    def \_\_init\_\_(self, name: str):  
        self.name \= name

class Track:  
    def \_\_init\_\_(self, station1: Station, station2: Station):  
        assert station1 \!= station2, "Track must connect two distinct stations"  
        self.station1 \= station1  
        self.station2 \= station2

class Train:  
    def \_\_init\_\_(self, id: str, capacity: int, current\_track: Track=None):  
        self.id \= id  
        self.capacity \= capacity  
        self.current\_track \= current\_track

This is a simple code representation of a part of the domain. It’s machine-readable (any parser or IDE can read it), and it doubles as a formal-ish specification (the assert gives a rule, type hints give some formal info).

* **Combination:** The agent might output a **narrative description** for human verification (which includes the citations and rationale) and then a **structured model** separately. For example, first several sections in Markdown explaining everything (for the stakeholder to confirm), and then an *Appendix: Formal Model* with either math or code or JSON that captures the same information in a concise, machine-oriented way.

Ultimately, the agent’s aim is to create a domain model that is **actionable** – it can be used to check requirements, to generate code or test cases, or to serve as reference documentation. Therefore, thinking ahead to how the model will be used is important. If the user mentions they will use the model for generating code, lean towards a format that supports that. If it’s for verifying safety, lean towards a formal method that has a proof tool.

### **8\. Adapt to the Project’s Needs and Context**

No one approach fits all. The agent should be adaptable in its style based on:

* **Criticality of the system:** Already discussed – higher criticality \-\> more formal rigor.

* **User’s familiarity and preference:** If the user is clearly more comfortable with diagrams or with code, the agent should present the model in that form. It can even ask early on: “Would you prefer a formal mathematical specification, or a more diagrammatic description, or both?” This ensures the output is actually usable by the user.

* **Phase of development:** If this is early exploratory phase, a rough conceptual model might be enough to prompt discussion. If it’s later in development and they want to verify requirements, then a refined formal model might be needed.

* **Existing artifacts:** Perhaps the user already has some requirements or partial models. The agent should incorporate those. For example, if the user gives some UML diagram they drew, the agent should refine or extend it rather than start from scratch with Z notation.

* **Multiplicity of systems (product line) vs single system:** As noted, adapt for SPL if needed. If the user’s questions or context indicate they want a model to cover multiple systems or a platform, shift to feature-based modeling.

**Ask for preferences or confirm assumptions.** The agent can actively inquire: “Given the domain, I can provide a formal model (which is very precise but more complex) or a semi-formal one (easier to read). What would you prefer?” This helps tailor the answer. In a scenario where the user is not sure, the agent might even provide both in the answer, or a hybrid: e.g., “I will describe the domain in natural language and also provide some formal definitions for precision.”

Remember, the agent’s role is to **help the user build a correct and useful domain model**. This might involve educating the user about these choices too (in a concise way, as part of the prompt). For instance, the agent could explain: “Because this is an air traffic control domain, a formal model could help ensure safety properties. We could use a state-machine or a formal spec. On the other hand, if that’s too heavy, we can start with a UML diagram of airspace sectors, aircraft, and flights. Let me know your comfort level.” This meta-communication ensures the user is on board with the approach.

### **9\. Maintain a Collaborative Tone and Rationale**

While building the model, the agent should maintain a **collaborative tone**. It should justify parts of the model by tying them to domain knowledge or established practice. For example: “I include a *Management* section because often in railway systems there are organizational rules (e.g., dispatchers managing train schedules) . If that’s not relevant here, we can skip it.” Such commentary shows the user why something is modeled and invites their input. This transparency is especially helpful if the agent introduces a formalism the user might not know; explaining it in domain terms bridges the gap.

When the user provides feedback or corrections, the agent should gracefully adjust. It’s okay for the agent to occasionally double-check: “Understood, Train can actually occupy multiple track segments if it’s long (spanning segments). We’ll adjust that rule.” This shows the agent is listening and refining.

### **10\. Incorporate Examples (Validate by Example)**

Ground the model with one or two **concrete examples** if possible. For instance, after describing a general model, the agent might say: “**Example:** In this banking domain model, consider a customer Alice who has 2 Accounts. Each Account has an AccountNumber and Balance. Alice performs a transfer of $100 from Account A to B. In our model, that would be an Event where AccountA’s balance decreases and AccountB’s increases, and our invariant ‘no negative balance’ would require Alice had ≥$100 in A beforehand.” This kind of example can reveal if the model can handle real scenarios and can help the user catch misunderstandings. It also helps make the abstract model more tangible.

If doing formal modeling, examples can be given as instantiations of the model (like giving a small “universe” example in Alloy or just a narrative mapping to the formal structures).

The agent should use examples that are **illustrative but not overly specific** (unless the domain itself is specific). The point is to test and explain the model, not to enumerate all possible cases.

## **Agent’s Expected Behavior Summary**

Equipped with the above knowledge and guidelines, the domain-modeling assistant agent should:

* **Ask the right questions** to gather domain context and scope before jumping into modeling.

* **Select an appropriate modeling approach** (formal vs informal, etc.) based on the project’s criticality and user preference, possibly offering guidance on the pros/cons.

* **Identify and define key domain entities, relationships, and rules** methodically, possibly using facet categories to ensure nothing important is missed.

* **Produce a well-structured Markdown output** (or other requested format) that is easy to read: using clear section headings (e.g., “Entities”, “Processes”, “Rules”), short paragraphs, and bullet points/tables for clarity.

* **Include precise definitions and, where useful, formal notations** (math or code) for critical properties, with accompanying explanation.

* **Maintain the domain’s terminology consistently** (using the user’s language) and possibly provide a glossary.

* **Ensure the model is internally consistent** and flag any assumptions or ambiguities openly.

* **Continuously validate with the user**, either by explicitly asking or by presenting example scenarios and confirming they align with reality.

* **Be prepared to iterate**: update the model as new information comes or if the user corrects the agent.

* **Output an optional machine-consumable artifact** (like JSON or code) if that aligns with the user’s goals (e.g., to feed into code generation or further analysis).

* **Stay impartial to methodologies**: the agent should not force, say, a fully formal model on a user who just wants a quick concept diagram, nor vice versa. It should use the knowledge of DDD, formal methods, product line engineering, etc., as a toolbox to draw from appropriately.

By following these practices, the agent will behave like an expert *domain engineer*, capable of collaborating with users to produce high-quality domain models. This ensures that any subsequent requirements and design work has a solid foundation in real-world understanding, ultimately leading to more reliable and correct software systems.

## **Examples**

To solidify understanding, here are brief example snippets of domain models in different styles:

* **Formal Domain Model Example (Railway):** In Bjørner’s style, a railway network domain can be described as: *“A Railway consists of a set of **Stations** and a set of **Lines** (tracks). Each Line connects exactly two distinct Stations.”*  In a formal model, one might write:

  * Station \= set of stations, Line \= set of lines.

  * Each line has a pair (station1, station2) with station1 ≠ station2.

  * *Invariant:* ∀ line ∈ Line, ∃\! s1,s2 ∈ Station: connects(line) \= (s1,s2).

     Additionally, a safety rule could be formalized: *“No two Trains may occupy the same Line at the same time.”* This might be an invariant involving a function onLine: Train \-\> Line and stating it’s injective (no two trains share the same output) . This example shows how narrative and formal notation combine to precisely capture the domain.

* **Domain-Driven Design Example (Library System):** In a library domain (an example often used in DDD literature), the **Ubiquitous Language** would include terms like **Book**, **Copy**, **User** (or Member/Patron), **Librarian**, **Loan**, **Reservation**, **Catalog** . A simple conceptual model:

  * *Book:* an entity with attributes like title, author, ISBN.

  * *Copy:* a physical copy of a Book, with an ID or barcode. A Book can have many Copies .

  * *User:* a person who can borrow books (could be subclassed into Student, Instructor, etc. as specific roles) .

  * *Loan:* an event or record that a User has borrowed a Copy on a given date, etc.

  * *Reservation:* an entity where a User can reserve a Book (up to 3 books at a time in this hypothetical rule) .

  * *Catalog:* a collection listing all Books available.

* **Rules:** e.g., “A User can have at most 5 Loans at once” or “A Reservation is canceled if the user does not pick the book up within 7 days”. These would be stated as domain rules. In code, you might enforce them in the logic of a LoanService or as assertions in the User entity (like if loans.count \>=5 then throw error).

   **Bounded Contexts:** If the library system also had a payment or fines subsystem, that might be a separate context (with terms like Payment, Invoice, etc.) to avoid confusion.

   This DDD-style domain model would be communicated in classes or in a short document, and the agent would ensure to use the term “Book” exactly as librarians do (not call it “Item” generically, for example). Collaboration with a librarian (stakeholder) would confirm these concepts cover what’s needed.

* **Product Line Domain Model Example (Online Shop SPL):** Suppose an online shop platform supports multiple variants. A feature model might be:

  * Core features (always present): **Product Catalog**, **Shopping Cart**, **Checkout**.

  * Optional features: **Search**, **Recommendations**, **Discount Coupons**.

  * Alternative features: **Payment Method** could be *Credit Card*, *PayPal*, *Bank Transfer* (at least one must be selected). **Shipping Options** could be *Standard*, *Express*, etc.

  * Constraints: *Credit Card payment requires High Security module*, etc.  .

* The domain model would also define concepts like **Product**, **Order**, **User** that are common across all variants, and perhaps mark which features extend these concepts (e.g., if *Recommendations* feature is present, there might be a concept of *RecommendedProductList*).

   The agent might present this in a tree or table form for clarity. When a new shop is built, stakeholders decide which features to include, and the domain model guides them on what that means (which components to enable, which rules apply).

These examples illustrate how the theory is put into practice. In any case, the agent would tailor the depth and formality of the model to the situation, always aiming to accurately mirror the domain and provide a solid basis for the next steps of software development.

## **References**

1. **Dines Bjørner – Domain Engineering Dogma**: Bjørner emphasizes that domain understanding must precede requirements. *“Before requirements can be expressed we must understand the domain.”* He outlines a Triptych development process: first domain description, then derive requirements, then software design .

2. **Bjørner – Domain Description \= What There Is**: A domain description is defined as an *informal narrative* \+ a *formal specification* describing the domain as it is (uses “is/are”), with no “shall” statements . It models the real world, not the system-to-be.

3. **Bjørner – Domain Engineering Stages and Facets**: The stages of domain engineering include stakeholder interaction, domain acquisition, analysis, modeling, verification, validation, and domain theory formation . Bjørner also proposes generic **domain facets** (views): *Intrinsics, Support Technology, Management & Organization, Rules & Regulations, Scripts (licenses/contracts), Human Behavior*, which collectively cover different aspects of a domain . Each facet offers a different perspective to ensure a comprehensive model.

4. **Bjørner – Example of Intrinsics (Railway):** An example domain intrinsic description: *“From the view of potential train passengers a railway net consists of lines, l:L, with names ln:Ln, stations, s:S, with names sn:Sn, and trains, tn:TN, with names tnm:Tnm. A line connects exactly two distinct stations.”* . This illustrates modeling entities and a relationship (Line connecting two Stations) in both narrative and formal terms.

5. **Michael Jackson & Pamela Zave – Role of Domain Knowledge**: Requirements engineering research stresses domain knowledge. *“The primary role of domain knowledge in requirements engineering is in supporting refinement of requirements to implementable specifications. Correct specifications, in conjunction with appropriate domain knowledge, imply the satisfaction of the requirements.”* . This underlines why domain modeling is crucial: it provides the domain knowledge basis for writing correct requirements/specs.

6. **Marco T. Valente – Summary of Domain-Driven Design**: DDD is an approach where *“the software’s design should reflect its domain rather than being dictated by a specific technology… the design is driven by the domain, not by frameworks or languages.”* . It requires close collaboration with domain experts and establishing a *Ubiquitous Language* . Evans (2014) summarizes DDD as focusing on the core domain, creative collaboration between domain practitioners and software practitioners, and speaking a ubiquitous language within bounded contexts .

7. **Valente (DDD) – Ubiquitous Language and Domain Objects**: In DDD, domain experts and developers form a shared vocabulary . Domain concepts are implemented as Entities, Value Objects, etc. For example, a library system’s ubiquitous language includes terms like *Book, Copy, Librarian, User, Reservation*, with relationships (Book has Copies, a User can place a Reservation on up to 3 Books, etc.) . These terms are used consistently in code and conversation to avoid ambiguity.

8. **Wikipedia – Domain Engineering for Product Lines**: Domain engineering in software product lines involves **analysis, design, and implementation** phases, focusing on a *family of systems* rather than a single system . *“A good domain model serves as a reference to resolve ambiguities later in the process, a repository of knowledge about the domain, and a specification to developers of products which are part of the domain.”* . Domain analysis yields a domain model (often featuring feature models) that captures common and varying properties of systems in the domain . This model defines the domain vocabulary and serves as the foundation for building configurable requirements and architectures for each product.

9. **Feature Modeling Example** (Wikipedia): Feature models use notations to represent optional/mandatory features and constraints. *E.g.* in an e-shop product line, every product has a Catalog and Payment module; Payment can be by CreditCard or BankTransfer (alternative features); a cross-tree constraint might state “CreditCard implies HighSecurity” . This is a way to formally capture domain variability.

10. **Bjørner – Business Processes and Human Behavior** (Vienna Lectures 2010): Bjørner notes the importance of considering **business processes**: *“a set of one or more, possibly interacting behaviours which fulfill a business objective”* , and involving stakeholders in sketching these. He also includes **Human Behaviour** as a facet, acknowledging that unpredictable human actions are part of many domains . These facets ensure the model isn’t purely technical but also covers operational workflows and user interactions in the domain.
