# Engineer Work Sample (Rails, ver 2020.11 EN)

Hi there **C**,

Hope all is well!

Here's your take-home project from Raksul.

Please submit your code before **Thursday, 10 Dec 17:47 JST**.

Best wishes,

// The Raksul HR team.

:heartpulse: :two_hearts: :revolving_hearts: :sparkling_heart:<br/>
:sparkles: :sparkles: :sparkles:<br/>
:joy_cat: :star: :star2: :beers: :star: :star2: :joy_cat:<br/>
<br/>

Read the following business case and implement the code to satisfy the requirements.

# Background

Suppose you’re helping a business owner of a used-mobile phone retail shop.

- There is only one shop, close to a busy train station.
- The shop currently has approximately 2,000 devices in their inventory.
- They sell approximately 200 devices per week.
- They also buy approximately 200 devices per week.
- Aside from the business owner, there is a store manager and two assistants.

The goal of the project is to build a website for customers, so they can browse the inventory catalog and place orders online.

After the first product planning meeting, you have decided to build a feature to satisfy the use case of “As a store manager, I can register inventory.”

Create a rails project and deliver the first feature!

# Instructions

Create a new Rails project. You have approximately 90~120 minutes to complete this assignment.

1. Design the database schema using ActiveRecord.

   - Make sure your schema captures the following properties: the manufacturer, model, storage size (e.g. 64GB), the year of manufacture, color, and selling price.

   - Normalize the tables as needed.

1. Visualize the wire-frame of the input form.

   - You may draw it on a piece of paper and capture it or with a diagramming tool.

   - You may also visualize this in plain HTML or with ruby templating engine (e.g. ERB, Slim, etc.), however, do note that we assume we’re building an SPA that makes calls to REST APIs.

1. Design the REST API end-points to support the suggested UI using config/route.

1. Implement the server-side API.

1. Write unit tests to validate your server-side APIs (preferably using RSpec).

1. **BONUS:** Implement the front-end and wire it up to the APIs you created using JavaScript/TypeScript.

# Guidelines

- Remember KISS (Keep it small and simple) and YAGNI (You ain’t gonna need it)

  - Some candidates try to impress us with all the whistles and bells and some engineers over-do things and end up introducing more complexity than needed.

  - Even in a real world scenario, time-to-market is extremely important. We like to keep things compact first, then allow it to expand as we learn more about our customers rather than guessing their needs and end-up creating features nobody needs.

- Try to commit often

  - We like to see the progress and learn about your thought process over time. It would help us learn that if you commit often!

# How To Submit Your Code

Create a feature branch named `challenge` and submit your code as a PR.

Once you're ready you _must request a PR review_ from the user `raksul-code-review`.

**Important:**

- Do NOT fork this repo.
- Do NOT merge your PR to main.
- Do NOT include vendor folders!

# Grading & What To Expect

We will grade you on code clarity, naming, code structure, project size and, most importantly, _correctness_.

**IMPORTANT: For this challange you will only be informed if you pass or not. We will NOT provide any additional feedback, so please do not ask for it!**

Good Luck :grin: !
