# **Research Task: Domain Modeling and Domain Engineering for LLM Agent**

## **Objective**

Gather and compile knowledge about **domain modeling** and **domain engineering**. The goal is to equip a coding assistant with expert understanding and methodology for creating domain models, especially for critical, high-assurance systems. Find relevant sources (academic papers, books, etc.), extract actionable insights, and produce a **technical, structured Markdown document** that defines the domain-modeling agent’s knowledge and behavior.

## **Research Focus and Requirements**

* **Dines Bjørner’s Definitions and Methodology:** Find how Dines Bjørner defines *domain modeling* and *domain engineering*. Summarize his **Triptych approach** (domain \-\> requirements \-\> software design) which asserts that understanding and describing the domain is a prerequisite to requirements and software specification . Include Bjørner’s characterization of a *domain* and what a *domain model/domain description* entails. For example, Bjørner describes a domain description as a **precise specification** (both informal narrative and formal mathematics) of the *actual world* (“what there is”), excluding any requirements or design – i.e. not what we want it to be and not the software itself . Highlight the **importance of domain modeling** in the software lifecycle (especially for high-assurance systems) as stressed by Bjørner (e.g., *“in order to prescribe requirements we must understand the domain”* ).

* **Domain Engineering Process (Bjørner and others):** Research Bjørner’s notion of *domain engineering* in detail. This includes the stages he describes (such as stakeholder identification, domain *acquisition*, domain *analysis*, domain *modeling*, and model *verification/validation* ). Note Bjørner’s concept of **domain facets** – different aspects one should consider in a comprehensive domain model. For instance, Bjørner’s lecture notes enumerate facets like **intrinsics**, **support technology**, **management and organization**, **rules and regulations**, **business processes**, **scripts (contracts/licensing)**, and **human behavior** . These facets provide a systematic way to ensure the domain description covers all relevant perspectives (from inherent properties of the domain to external regulations and human interactions). Gather actionable guidance on how to apply these facets when modeling a domain. Also, include that domain models for critical systems often benefit from **formalization** (using mathematical notation or formal specification languages) to avoid ambiguity and enable verification . The agent’s context should reflect that *high-assurance systems* demand rigor; hence domain modeling may involve formal methods (set theory, logic, state machines, etc.) to precisely capture domain properties.

* **Other Approaches to Domain Modeling (Historical and Modern):** In addition to Bjørner, gather information on **alternative and complementary domain modeling approaches** over time, ensuring the agent is aware of multiple paradigms and can choose appropriately based on context:

  * *Domain-Driven Design (DDD):* Summarize the key ideas of DDD (Eric Evans, 2003\) as an approach that **aligns software design with the business domain** by modeling core domain concepts directly in code . Emphasize how DDD insists on understanding the business/domain deeply before coding, and using a **Ubiquitous Language** – a shared vocabulary between developers and domain experts – to create a common model of the domain . Highlight concepts like *Entities, Value Objects, Aggregates,* and the importance of capturing business rules in the domain model. DDD is less formal than Bjørner’s approach but very practical; it helps ensure the software reflects real-world complexity by close collaboration with domain experts  . Include actionable points such as: in DDD the agent should identify bounded contexts (separate sub-domains with their own models), and always use domain terminology consistently (avoiding tech-jargon for core concepts). This approach is valuable for many enterprise systems, though for life-critical systems one might still incorporate formal verification techniques.

  * *Software Product Line Domain Engineering:* Include information on domain engineering in the context of **systematic reuse and product lines**. Domain engineering here refers to developing a **domain model and reusable assets** that capture the commonalities and variabilities of a family of related systems  . Instruct the agent on concepts like **feature models** (for variability), and how domain **analysis** in this approach is about identifying features that span multiple products. Note that domain engineering typically consists of **domain analysis, domain design, and domain implementation** phases . A good domain model in this paradigm serves as a reference to resolve ambiguities and as a knowledge repository for the domain, guiding the development of new system variants . The agent should understand that if the user’s goal is to build *many similar systems or a software product line*, this approach would focus on modeling features and using those models to generate requirements/designs for each product.

  * *Conceptual Modeling and Ontologies:* Briefly mention that domain modeling can also be done via conceptual models (like **UML class diagrams or ER diagrams**) or even **ontology engineering** in knowledge representation. These are more diagrammatic or semantic approaches. For completeness, the agent should know that a *domain model* is essentially a conceptual model of the problem domain – it can be represented in various forms (UML, ontology, informal diagrams) when formality is not required to the same degree as in high-assurance systems. For example, using a UML class diagram to depict key entities and relationships in the domain is a common practice in less critical projects. In contrast, formal methods (Z, VDM, Alloy, etc.) produce mathematically rigorous domain models suitable for verification . The agent should be able to decide when an informal conceptual model suffices versus when a formal model is warranted (based on the criticality and needs of the project).

* **Best Practices and Principles for Domain Modeling:** Compile **actionable best practices** that the agent should follow while assisting in domain modeling:

  * *Understand and Define Domain Scope:* The agent should always start by clearly defining the **boundaries of the domain** – what is included vs. what is out of scope . This involves identifying the primary purpose of the system and the relevant part of reality (domain) it operates in.

  * *Engage with Domain Knowledge:* Emphasize the need to gather domain knowledge (from user input, domain experts, or documentation). The agent should possibly prompt the user for any missing domain details. Academic insight: requirements engineers Zave & Jackson note that **domain knowledge** (domain assumptions) is essential for refining requirements into a correct system specification  – the agent should treat domain understanding as fundamental. In practice, this means the agent might ask clarifying questions like “Can you describe how X works in your domain?” to ensure it has the facts right, and the user could provide domain knowledge materials, or a separate agent can conduct an interview with the expert to gather this knowledge.

  * *Use Precise Language:* Encourage use of unambiguous terminology. If operating in a formal mode, the agent should define terms rigorously (even mathematically). If in an informal mode, it should still avoid vague terms. The **Ubiquitous Language** concept from DDD is useful here – the agent should adopt the user’s domain vocabulary and ensure consistency . It may even output a glossary of domain terms as part of the model to solidify understanding. Another way to talk about this is Controlled Natural Language.

  * *Structure the Domain Model:* The agent should organize the domain model in a logical structure. For instance, it can break the model into sections corresponding to Bjørner’s facets or similar categories:

    * **Intrinsics:** The inherent properties and **entities** of the domain (e.g. physical objects, conceptual entities, their relationships and attributes) .

    * **Static vs Dynamic aspects:** Enduring entities vs. behaviors (Bjørner distinguishes *endurants* and *perdurants*, i.e., objects vs. processes/events ).

    * **Processes/Business Processes:** How things in the domain behave or interact over time (workflows, sequences of activities).

    * **Rules and Regulations:** Any policies, laws or rules that constrain the domain behavior .

    * **Supporting Technology:** Any tools or infrastructure in the domain (e.g. in a railway domain, the signaling system is a support technology).

    * **Actors and Organizations:** Human roles or organizational units in the domain (if applicable to understanding responsibilities, permissions, etc.).

    * This structured approach ensures **completeness** and clarity. The agent’s context should instruct it to systematically consider each aspect for a given domain, so that nothing critical is overlooked.

    These may not be the right categories, base this part on what your research shows.

  * *Iterative Refinement:* Advise that domain modeling is often iterative. The agent should be prepared to refine the model as new information comes to light or if the user provides corrections. It’s acceptable (even encouraged) for the agent to verify its understanding by summarizing parts of the model and asking “Is this accurate?” to the user. High-assurance systems especially benefit from careful validation of the domain model by stakeholders.

  * *Validation and Verification:* The agent should validate the domain model with the user (or other domain sources) to ensure it accurately reflects reality. In formal approaches, *verification* might include checking the model’s consistency or invariants. Bjørner’s methodology calls for *domain model verification and validation* as distinct steps  – the agent should likewise confirm the model internally (no contradictions, completeness) and externally (aligned with real-world domain knowledge). For example, after modeling, the agent might restate key domain properties: “Given this model, do all these statements hold true in the real domain?”

  * *Machine-Readable Output:* Since the goal is a **machine-readable domain model**, instruct the agent to consider output formats that can be parsed or utilized by other tools or later phases (requirements, design). This could be:

    * A **formal specification** (in a language like Z, VDM, Alloy, or a custom DSL) that precisely defines sets, types, state variables, and operations of the domain.

    * A structured data format (JSON/XML/YAML) capturing the domain entities, relationships, and constraints.

    * Or even well-structured **pseudo-code or type definitions** (for example, using a programming language’s type system to represent the domain concepts).

    * The context prompt should note that plain text explanations are useful for human communication, but the agent should aim to also provide a structured representation. It might output both: a narrative description *and* a formal/model artifact. For instance, the agent could list domain entities with their attributes and constraints in a tabular or code form.

  * *Adaptability:* Importantly, the agent should **choose the modeling approach appropriate to the task at hand**. It must not be biased toward one methodology universally. Instead:

    * If the system is **safety-critical or requires mathematical rigor**, favor a formal model (set theory, algebraic specification, state machines, etc.) and cite domain properties formally. (E.g., model train routes and interlocks in a railway domain with precise invariants for safety).

    * If the project is an **enterprise software application**, a more informal or object-oriented domain model (like a class diagram or DDD-style description) might be more practical and easier for stakeholders to understand. The agent can still be precise but in the language of the business (e.g., classes for Order, Customer, Invoice with business rules).

    * If the goal is to build a **software product line** or handle **reuse**, the agent might focus on feature modeling and highlight what is common vs variable in the domain (per product line practices ).

    * The agent’s context should prepare it to **ask the user what style they prefer** or make an informed suggestion based on the domain (for example, “Given that this is an air traffic control system, I recommend we create a formal model in Z for precision. Does that sound acceptable?”).

* **Example Domain Models (for Reference):** While not the top priority, if you run into good **illustrative examples** of domain models from literature, especially those that are not overly specific (so they can be shown as generic patterns). For instance:

  * A small excerpt from Bjørner’s **Container Line Industry** domain example (if available) to show how he mixes informal and formal description of a transportation domain

  * A simple example of a domain model in a DDD context (e.g., a snippet of a **Bank Account** domain: listing Entities like Account, Transaction and their rules).

* These examples, if found, could be included in an appendix or a “Examples” section of the compiled context. They would serve as few-shot prompts or inspiration, demonstrating how to apply the theory in practice. Ensure any included example is sufficiently **neutral/generic** (so it doesn’t bias the agent toward a very specific domain). If detailed examples are found but too domain-specific, the agent can summarize their structure instead of including full lengthy texts. (For instance, “In Bjørner’s railroad domain model , he defines sets like Track, Train, and a function mapping Track to Occupancy to ensure no two trains conflict – illustrating formal representation of domain rules.”) Such examples can be referenced for later use, but they should not overwhelm the prompt. The primary goal is the overall context prompt.

## **Deliverable Format and Style**

This should result in a **well-organized Markdown document** that can serve directly as the **context prompt for the domain-modeling assistant agent**. Key points for the format:

* Use a clear heading structure (with \#, \#\#, etc.) to delineate sections as outlined above (e.g., **Overview**, **Methodologies**, **Best Practices**, **Agent Behavior**, **Examples**). This will make it easy for a reader (or the agent itself) to scan and find relevant guidance.

* Ensure paragraphs are concise (3-5 sentences each) for readability. Use bullet lists where appropriate (for steps, principles, or enumerations of concepts like facets or best practices) so that the information is easy to absorb quickly.

* The **tone** of the compiled context should be **technical, precise, and actionable**. It’s essentially programming the behavior of the domain-modeling agent, so it can include directive language (e.g., “Use X to…”, “Write and run…”, “Ensure that…", “Create the…”,”) alongside explanatory content. It should read like a knowledge base and instruction manual for performing domain modeling.

* If there is enough diversity in overall approaches (i am not sure there is), the final compiled prompt should **cover multiple perspectives impartially**. It should not advocate only one methodology; rather, it should educate the agent about each and when it is appropriate. By presenting Bjørner’s formal approach alongside DDD and product-line engineering, the agent will not be biased and can draw on the right approach for the situation at hand, for example.

* Emphasize throughout the context that the agent’s ultimate role is to **help the user build a correct and complete domain model**. The agent should be proactive in knowledge gathering (asking the user domain-specific questions), rigorous in ensuring the model’s quality (using the best practices from research), and flexible in presentation (able to output models in various forms as needed).

By assembling information and guidelines in this way, you will produce a thorough context document. This document will effectively **“train” the coding assistant agent in domain modeling** — giving it the theoretical foundation (from domain science and engineering research) and practical guidance (steps and examples) to collaborate with a user on building machine-readable domain models for complex systems.