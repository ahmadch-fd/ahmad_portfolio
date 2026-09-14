AGENTS.md
Flutter Development Rules

You are an expert Flutter/Dart coding agent.

This project follows:

Flutter
Dart
Provider
MVVM Architecture
REST APIs
Scalable and maintainable code
Responsive UI

Your goal is to write clean, optimized, production-ready Flutter code while avoiding hallucinations, unnecessary code, duplicated logic, and unnecessary dependencies.

1. GOLDEN RULE

When uncertain:

DO NOT GUESS.

First:

Inspect the existing project.
Read the relevant files.
Check pubspec.yaml.
Check existing architecture and patterns.
Verify APIs and package usage.
Then implement.

Never invent:

files
classes
methods
package APIs
REST API endpoints
JSON fields
routes
model properties
package versions
project requirements

If something cannot be verified, inspect the project or clearly state what is missing.

2. PROJECT ARCHITECTURE

This project uses:

Provider + MVVM + Repository Pattern.

Follow this flow:

View
  ↓
ViewModel
  ↓
Repository
  ↓
API Service
  ↓
REST API

The UI must not directly call APIs.

The ViewModel must not contain raw HTTP implementation.

The Repository must not contain UI code.

Keep responsibilities separate.

Recommended scalable structure:

lib/
│
├── core/
│   ├── constants/
│   ├── network/
│   ├── services/
│   ├── utils/
│   ├── errors/
│   └── theme/
│
├── data/
│   ├── models/
│   └── repositories/
│
├── view_models/
│
├── views/
│   ├── screens/
│   └── widgets/
│
├── providers/
│
└── main.dart

Do not create unnecessary folders.

Do not over-engineer a simple feature.

Follow the existing project structure if it already exists.

3. RESPONSIBILITY RULES
View

The View is responsible only for:

displaying UI
receiving user interaction
listening to Provider state
navigation
showing dialogs/snackbars when appropriate

Do NOT put:

API calls
business logic
JSON parsing
large calculations

directly inside UI widgets.

ViewModel

The ViewModel is responsible for:

application state
UI state
loading state
error state
success state
validation
coordinating repositories

ViewModels should extend:

ChangeNotifier

Do not put UI widgets inside ViewModels.

Do not use BuildContext inside a ViewModel unless absolutely necessary.

Prefer exposing state and methods so the View reacts to changes.

Repository

The Repository is responsible for:

requesting data
sending data
converting API responses into models
handling data-related logic

Repositories communicate with API services.

Repositories must not contain UI code.

API Service

The API Service is responsible for:

GET requests
POST requests
PUT/PATCH requests
DELETE requests
headers
authentication tokens
request configuration
response handling
network exceptions

Do not duplicate HTTP logic across multiple files.

Use a centralized API service.

4. PROVIDER RULES

Use Provider correctly and efficiently.

Avoid unnecessary rebuilds.

Prefer:

context.read<T>()

when calling methods without listening.

Use:

context.watch<T>()

only when the widget needs to rebuild when state changes.

Use:

Consumer<T>

for smaller rebuild areas.

Do not wrap an entire screen in Consumer if only one small section needs rebuilding.

Minimize unnecessary widget rebuilds.

Provider State

Avoid scattered boolean variables when a clear state structure is better.

For asynchronous operations, manage:

initial state
loading state
success state
error state

Prefer clear and predictable state.

Do not call notifyListeners() unnecessarily.

Only notify listeners when the observable state has actually changed.

5. REST API RULES

Never invent an API.

Before implementing an API, verify:

base URL
endpoint
HTTP method
request headers
authentication
query parameters
request body
response JSON
error response

Do not guess JSON keys.

Use the actual API response.

Follow this flow:

REST API
   ↓
API Service
   ↓
Repository
   ↓
Model
   ↓
ViewModel
   ↓
View
6. API ERROR HANDLING

Handle errors properly.

Consider:

no internet connection
timeout
unauthorized requests
forbidden requests
validation errors
server errors
invalid responses
unknown errors

Do not silently ignore exceptions.

Bad:

try {
  await fetchData();
} catch (_) {}

Use meaningful error handling.

Do not expose raw technical errors directly to users unless appropriate.

Create reusable error handling instead of repeating the same try/catch logic everywhere.

7. MODEL RULES

Create models based on actual API responses.

Never guess JSON fields.

Models should handle:

null values
optional fields
missing values
type differences when realistically possible

Avoid excessive use of:

dynamic

Avoid unnecessary:

!

Prefer proper null safety.

Keep models focused on data representation.

Do not put UI logic inside models.

8. SCALABILITY RULES

Write code that can grow.

Prefer reusable solutions.

Avoid:

duplicated API calls
duplicated widgets
duplicated constants
duplicated validation
duplicated error handling
duplicated loading logic

Before creating something new, search the project to check whether it already exists.

Prefer:

Reuse
↓
Extend
↓
Create new only when necessary

Do not create unnecessary abstraction layers.

Do not create ten files for a simple feature.

Balance scalability with simplicity.

9. CLEAN CODE RULES

Write readable and maintainable code.

Prefer:

meaningful names
small focused methods
small reusable widgets
clear responsibilities
final where appropriate
const where appropriate
proper null safety
enums for fixed states when useful

Avoid:

giant files
giant methods
deeply nested widget trees
unnecessary comments
unnecessary abstractions
magic numbers
unused variables
dead code
duplicate code

Do not leave commented-out old code.

Remove code that is no longer needed.

Keep the project junk-free.

10. NO JUNK CODE

Do NOT add:

unused imports
unused variables
unused methods
unused classes
placeholder methods
empty unnecessary files
duplicate utilities
unnecessary helper classes
dead code
commented-out code
unnecessary packages

Every file and every piece of code must have a purpose.

If code becomes unused after a change, remove it safely.

11. PERFORMANCE RULES

Prioritize correctness first.

Then optimize unnecessary work.

Avoid:

expensive calculations inside build()
unnecessary API calls
unnecessary Provider rebuilds
duplicate network requests
unnecessary object creation
rebuilding large widget trees
loading unnecessary data

Use lazy widgets where appropriate:

ListView.builder
GridView.builder

Do not optimize prematurely.

Only add complex optimization when it solves a real problem.

12. WIDGET OPTIMIZATION

Prefer:

const widgets where possible
extracted reusable widgets
Consumer for targeted rebuilds
Selector when appropriate for highly targeted state listening

Avoid rebuilding an entire screen for a small state change.

Keep build() methods clean.

If a widget section becomes large or reusable, extract it.

Do not extract tiny widgets unnecessarily just to create more files.

13. RESPONSIVE UI RULES

Every UI must be responsive.

The application should work properly on:

small Android phones
normal phones
large phones
tablets
landscape orientation when relevant

Do not design for only one screen size.

Avoid Fixed Sizes

Avoid unnecessary hard-coded:

width: 400
height: 800

Use available space intelligently.

Prefer when appropriate:

screenutil package
LayoutBuilder
Expanded
Flexible
Spacer
FractionallySizedBox
AspectRatio

Use responsive layouts based on available constraints.

14. RESPONSIVE DESIGN STRATEGY

Before building a complex UI, consider:

Small Screen
     ↓
Normal Phone
     ↓
Large Phone
     ↓
Tablet

For different widths:

adjust spacing when necessary
adjust grid columns
adjust layout direction
prevent overflow
maintain readable text
preserve touch-friendly controls

Use LayoutBuilder when layout decisions depend on available width.

Do not use random hard-coded breakpoints without a reason.

15. OVERFLOW PREVENTION

Always consider:

small screens
large text
keyboard visibility
long API content
long usernames
different device sizes

Use appropriate widgets such as:

Expanded
Flexible
SingleChildScrollView
ListView
SafeArea
TextOverflow

Do not use Expanded inside an unbounded height unless the layout supports it.

Do not introduce RenderFlex overflow.

16. TEXT RESPONSIVENESS

Do not assume text will always be short.

API data may contain:

long names
long titles
long descriptions
unexpected values

Handle text safely.

Use appropriate:

maxLines
overflow
flexible layout

Do not force text into fixed small spaces.

17. IMAGE HANDLING

For network images:

handle loading
handle errors
avoid broken UI when URLs are invalid
maintain appropriate aspect ratios

Do not assume every API image URL is valid.

Use reusable image handling when the same pattern appears repeatedly.

18. ASYNC OPERATIONS

Every API operation should properly handle:

Initial
↓
Loading
↓
Success
OR
Error

Do not leave the UI stuck in loading state.

Ensure loading state is reset after:

success
failure
exceptions

Avoid multiple duplicate requests caused by repeated UI actions.

19. VIEWMODEL RULES

ViewModels should:

have a clear purpose
manage one logical feature or related responsibility
expose readable state
delegate data work to repositories
notify listeners only when necessary

Do not create one giant ViewModel for the entire application.

Split ViewModels by feature when appropriate.

Example:

AuthViewModel
ProductViewModel
ProfileViewModel
HomeViewModel

Do not create unnecessary ViewModels for tiny static widgets.

20. UI RULES

Before creating new UI:

Inspect the existing theme.
Inspect colors.
Inspect typography.
Inspect reusable widgets.
Follow the existing design language.

Do not redesign unrelated screens.

Reuse existing:

buttons
text styles
colors
spacing
cards
input fields
common widgets

Keep UI consistent.

21. NAVIGATION RULES

Before adding navigation:

Inspect the existing navigation system.

Do not introduce a second navigation system.

Do not invent routes.

Follow the existing pattern.

Keep navigation logic clean and predictable.

22. PACKAGE RULES

Before adding any package:

Check pubspec.yaml.
Check whether the functionality already exists.
Check whether Flutter/Dart can solve it without a package.
Verify package compatibility.
Verify the package API.
Add the package only if genuinely needed.

Do not install packages unnecessarily.

After changing dependencies:

flutter pub get

Then verify:

flutter analyze
23. DEBUGGING WORKFLOW

When an error occurs:

Do NOT randomly modify multiple files.

Follow this process:

1. Read the complete error
        ↓
2. Find the exact file and line
        ↓
3. Inspect surrounding code
        ↓
4. Identify root cause
        ↓
5. Make the smallest correct fix
        ↓
6. Format the code
        ↓
7. Run analyzer
        ↓
8. Run relevant tests
        ↓
9. Verify the result

Fix the root cause.

Do not only hide the symptom.

24. MINIMAL CHANGE PRINCIPLE

If the request is small, make a small change.

Do not:

rewrite the architecture
rename unrelated files
replace Provider
replace repositories
update packages
redesign UI
refactor the entire project

unless it is required or explicitly requested.

Preserve working code.

25. TASK WORKFLOW

For every non-trivial task:

STEP 1 — INSPECT

Read:

pubspec.yaml
relevant files
relevant models
repositories
API services
ViewModels
Providers
Views/widgets

Understand the existing implementation.

STEP 2 — PLAN

Before implementing a large feature, create a short plan.

Include:

Files to modify
Files to create
Existing code to reuse
API requirements
State changes
Responsive considerations
Verification steps

Do not immediately generate hundreds of lines of code for a complex feature.

STEP 3 — IMPLEMENT

Implement the smallest clean solution.

Follow:

View
↓
ViewModel
↓
Repository
↓
API Service

Do not mix responsibilities.

STEP 4 — FORMAT

Run:

dart format .

Or format only modified files when appropriate.

STEP 5 — ANALYZE

Run:

flutter analyze

Fix actual analyzer problems.

Do not suppress warnings just to make the analyzer clean.

STEP 6 — TEST

When tests exist or the feature requires testing:

flutter test

Run relevant tests.

For API or UI changes, verify behavior where possible.

26. COMPLETION RULE

Never say:

"Done"
"Fixed"
"Everything works"
"Production ready"

unless the relevant verification was actually performed.

Before claiming completion:

code implemented
code formatted
analyzer checked
relevant tests run
feature verified when possible

If something could not be verified, explicitly say:

UNVERIFIED:
<Explain exactly what could not be tested and why>
27. FINAL RESPONSE FORMAT

After completing a task, report:

Changed:
- What files/code were changed.

Why:
- Why the change was necessary.

Verification:
- Commands/tests actually run.

UNVERIFIED:
- Anything that could not be verified.

Do not claim verification that did not happen.

28. EXPLANATION STYLE

The developer is learning Flutter.

When explaining:

use simple English
be direct
explain WHY
explain the code flow
avoid unnecessary theory
do not overwhelm with advanced concepts

For errors use:

Problem
↓
Why
↓
Fix
↓
Verify
29. FINAL CHECKLIST

Before completing a task:

[ ] Did I inspect existing relevant code?

[ ] Did I follow Provider + MVVM + Junk Free?

[ ] Did I keep API logic out of the UI?

[ ] Did I keep HTTP logic centralized?

[ ] Did I avoid inventing APIs or JSON fields?

[ ] Did I avoid unnecessary dependencies?

[ ] Did I avoid duplicate code?

[ ] Did I remove unused code?

[ ] Did I minimize unnecessary Provider rebuilds?

[ ] Is the UI responsive?

[ ] Did I check small and large screen behavior?

[ ] Did I consider long text and API data?

[ ] Did I prevent overflow?

[ ] Did I handle loading?

[ ] Did I handle errors?

[ ] Did I use null safety correctly?

[ ] Did I format the code?

[ ] Did I run flutter analyze?

[ ] Did I run relevant tests?

[ ] Did I honestly report anything unverified?

FINAL PRIORITY

Always prioritize:

Correctness
    ↓
Existing Architecture
    ↓
Scalability
    ↓
Maintainability
    ↓
Performance
    ↓
Clean Code
    ↓
Responsive UI
    ↓
Speed

Never sacrifice correctness for speed.

Never guess when the project or API can be inspected.

The golden workflow is:

INSPECT
   ↓
UNDERSTAND
   ↓
PLAN
   ↓
IMPLEMENT
   ↓
FORMAT
   ↓
ANALYZE
   ↓
TEST
   ↓
VERIFY