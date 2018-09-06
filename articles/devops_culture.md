Before you start reading this blog post, I want you consider this question: What is DevOps?

If you think DevOps are just the magicians that handle your infrastructure and services, you should continue reading this blog post to learn what "DevOps" really mean.

![](/uploaded/32067d267749fea374b45/devopsculture-magician.png)

## Why DevOps

DevOps was born because Devs wanted to ship their features fast to lead in the marketplace and make customers love their product. On the otherside, Ops wanted to improve stability over anything else, and new features mean instability. This creates a big conflict within the company.

![](/uploaded/32067d267749fea374b45/devopsculture-wall.png)

We needed to become more efficient as a company and work together towards the same goal. And here, they started copying Lean principles to eliminate bottlenecks and enhance productivity.

> _Note_: Lean is a management philosophy used by Toyota manufactures that allowed them to grow from a small company to the world's largest automaker in the 1990s (beating all their competitors).

## So what is DevOps?

In the State of Devops report 2017, devops is described as:

> DevOps is an understood set of practices and cultural values that has been proven to help organizations of all sizes improve their software release cycles, software quality, security, and ability to get rapid feedback on product development.

In this same document, they also compared high performing companies vs lower performing companies. Where they show that high performers reduce speed (or lead times) while improving stability.

![](/uploaded/32067d267749fea374b45/display/screen_shot_2018-08-20_at_15.55.05.png)

Keep in mind DevOps is not a team, it is a culture, so engaged leadership is essential for successful DevOps transformations.

## DevOps Principles

There are three principles or ways to get a DevOps culture (this were defined by Gene Kim, John Willis, Jez Humble and Patrick Debois on The Devops Handbook):

**1 - Flow of work**: this principle pursuits a release of features to our customers. We can achieve this by reducing our lead time. Practices that help reducing lead times are:

*   Eliminate constrains: All the work in the workflow should be identified. In general, this includes: design (queue, analysis, work and approvals), development (queue, estimation, development, tests and approvals), qa (queue, automated tests and manual tests) and deployment (queue, ops work, approvals, deployment, verification). Once we have the whole workflow, constrains (bottlenecks) should be determined and reduced (or eliminated).
*   Split features: smaller features will take less to be tested and deployed to production.
*   Reduce Waste: this is partially done work, extra processes with no value, features that are not needed, task switching, blocked tickets, motion, bugs (the longest it takes to find a bug, the more expensive it becomes to fix it), manual work (or toil) and heroics.
*   Improve our daily work: accumulating problems and technical deb, we can end up jus performing workaround for everything. Mike Orzen obserbed that "Even more important than daily work is the improvement of daily work". At least 20% of all Development and operation cycles should be invested on refactors, automate work and NFRs.
*   Integrate designated Ops and QAs into dev teams. So you have independent teams that dont need to open tickets to other teams to complete a feature. The structure of the teams is highly importnat, according to Conway's Law "organizations which design systems ... are constrained to produce designs which are copies of the communication structures of these organizations".

**2 - Feedback**: in order to have a resilient system, we should increase the information flow from as many areas as possible (sooner, faster and cheaper).

*   Create telemetry and analyse it. We should have a list of events for our system at business level, Application level, Infrastructure level, Client software level and deployment pipeline level.
*   Continuous integration allows devs to deploy and test their features in a real environment. Getting quick feedback and fixing bugs. Devs should be able to run unit tests, acceptance tests, integration tests (and have a visible test coverage). We could also perform performance tests by runing the same integration test multiple times in parallel. Static code analysis could be also automated for security or clean code.
*   Using continuous delivery provides the opportunity to get feedback from actual customers. Note: when there are shared goals in Devs and Ops, and there is transparency, reposibility and accountability for deployment outcomes, it doesnt matter who performs the deployment.
*   Enable different types of deployment: canary deployment, A/B testing and Blue-Green to probe releases or hypothesis.

**3 - Continual Learning and Improvement**: this focuses on organizational knowledge. For this we need:

*   Having a Safety culture where there is transparency and there is no secrecy for self-protection. We want to stablish a culture where information and responsibilities are shared, bridging between teams and pointing out failures is rewarded,...
*   Bad Apple theory: Dr Dekker asserts that is invalid to eliminate error by eliminating people who caused errors. Human error is a consequence of the design of the tools that we gave them. We should always perform blameless postmortem to incentivate learning rather than punishment. We should also avoid solutions like "be more careful".
*   Chaos Monkey: we cannot know if we are resilient until we test it. It was invented in 2011 by Netflix and has helped them survive to several AWS downtimes since then.
*   Convert local discoveries into Gloval improvements by adding telemetry or creating documentation for it.
