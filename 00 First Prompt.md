Help me write a prompt for GPT-5-Pro research, which is an AI that does deep work, to do the following: 

Find relevant sources about domain modeling and domain engineering, as defined by Dines Bjørner but also others over time. Compile it into a comprehensive, technical context file/prompt for an LLM coding agent that can do domain modeling with you. This prompt would define comprehensively the behavior of this practical, applied agent.

The idea is that you would tell the agent about the system you want to build, and it would help you create a machine readable domain model (so not just plain text preferably, but plain text is one way of describing things as you'll see when you look into domain modeling). the context/prompt should be actionable for a coding agent, and it should be based on deep domain modeling approaches from everything we can find about the topic.

this domain model would then be used by requirements and other implementation later on, but that is out of scope for this particular agent.

Your task is to write a prompt for a capable AI to come up with this context prompt for the agent

---

To write a precise prompt for GPT-5-Pro to generate the context prompt you’re describing, could you clarify a few things:

1. What kind of sources should be prioritized? (e.g., academic papers, books, software engineering blogs, official documentation)

2. Should the output context prompt include examples of domain models or just definitions and guidance?

3. Do you want the final context to follow a particular format (e.g., structured JSON, markdown, plain text)?

4. Should the GPT-5-Pro research include critiques or comparisons of different domain modeling approaches, or just integrate them?

5. Are there any specific systems or domains you want to bias the context toward (e.g., embedded systems, finance, health care)?

Once I have this, I can write an optimal prompt to send to GPT-5-Pro.

---

1\. academic papers and books that have actionable insights, anything that helps the agent actually be an expert in creating a domain model.

2.examples that are neutral enough for a "few shot prompting" approach would be good. If it finds really good detailed examples, let's collect them so we can use the later, but that is not a priority. 

3\. markdown

4\. The agent will work primarily with critical systems that need high assurance. If there are truly completely different approaches to domain modeling, it should make the agent aware of that, and the agent should make decisions about which approach to take depending on the task at hand. 

5\. Not biased in anything in particular.

—