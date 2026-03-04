Project 4 – Trivia
Submitted by: David Requeno

Trivia is an app that fetches real questions from the Open Trivia Database API and lets users answer multiple‑choice questions in a clean, simple quiz format. The app tracks score, shows correct/incorrect feedback, and allows the user to restart with a new set of questions.

Time spent: 2 hours spent in total

Required Features

The following required functionality is completed:

[x] User can view and answer at least 5 trivia questions.

[x] App retrieves question data from the Open Trivia Database API.

[x] Fetches a different set of questions when the user resets the game.

[x] Users can see their score after answering all questions.

[x] True/False questions only show two answer options.

Optional Features

The following optional features are implemented:

[x] User can choose a specific category of questions (Category 28 – Vehicles).

[x] User receives feedback on whether each question was correct before moving to the next.

Additional Features

The following additional features are implemented:

[x] HTML decoding for special characters in API questions/answers.

[x] Answer buttons visually update (green/red) to show correctness.

[x] Clean UI with hidden buttons for questions with fewer than 4 choices.

[x] Restart button appears automatically at the end of the quiz.

Video Walkthrough

https://www.loom.com/share/f1ae1628145e47d8a54d395eefc0960c

Notes
One challenge was configuring Auto Layout so the question text appears centered. The label needed proper leading/trailing constraints instead of being pinned edge‑to‑edge. Another challenge was decoding HTML entities from the API and shuffling answers while keeping track of the correct one.

Copyright 2026 David Requeno

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
