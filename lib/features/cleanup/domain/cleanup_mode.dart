enum CleanupMode { clean, precise, meeting, lecture, journal, bullets }

extension CleanupModeExtension on CleanupMode {
  String get label => switch (this) {
        CleanupMode.clean => 'Clean Up',
        CleanupMode.precise => 'Precision',
        CleanupMode.meeting => 'Meeting Notes',
        CleanupMode.lecture => 'Lecture Notes',
        CleanupMode.journal => 'Journal Entry',
        CleanupMode.bullets => 'Bullet Points',
      };

  String get description => switch (this) {
        CleanupMode.clean => 'Fix grammar, remove fillers',
        CleanupMode.precise => 'High-density technical extraction',
        CleanupMode.meeting => 'Action items + decisions',
        CleanupMode.lecture => 'Key concepts + structure',
        CleanupMode.journal => 'Personal, reflective tone',
        CleanupMode.bullets => 'Concise bullet points',
      };

  String get icon => switch (this) {
        CleanupMode.clean => '✨',
        CleanupMode.precise => '🎯',
        CleanupMode.meeting => '📋',
        CleanupMode.lecture => '🎓',
        CleanupMode.journal => '📔',
        CleanupMode.bullets => '•',
      };

  String get prompt => switch (this) {
        CleanupMode.clean => '''
You are a high-precision transcript editor. Clean up the following raw voice transcript to make it perfectly readable while preserving 100% of the original information.
- ABSOLUTELY REMOVE all filler words: uh, um, like, you know, basically, literally, right, I mean, actually.
- Fix grammar, punctuation, and sentence structure without changing meaning.
- Remove all repetitions, false starts, and verbal stutters.
- Ignore and remove acoustic artifacts or noise descriptors (e.g., [noise], (laughter), background voices).
- If the transcript is incoherent in parts, try to reconstruct the logical flow.
- Output ONLY the cleaned text. No headers, no intro, no outro.
''',
        CleanupMode.precise => '''
You are a technical data extraction specialist. Extract the core high-density information from this raw transcript.
- Strip away all conversational fluff, social pleasantries, and unnecessary context.
- Focus on technical facts, numbers, dates, names, and specific instructions.
- Format the output as a highly structured, dense logical flow.
- Ensure zero loss of critical technical detail.
- Ignore all background noise and acoustic interference.
- Output ONLY the dense extraction.
''',
        CleanupMode.meeting => '''
You are an executive assistant. Transform this meeting transcript into a structured professional report.
Format:
**OBJECTIVE:** (Primary goal of the meeting)
**DECISIONS:** (Numbered list of final decisions)
**ACTION ITEMS:** (Task | Owner | Deadline if mentioned)
**KEY DISCUSSION POINTS:** (Bullet list of core topics)
- Remove all informal speech and fillers.
- Focus on outcomes rather than the back-and-forth conversation.
- Output ONLY the formatted report.
''',
        CleanupMode.lecture => '''
You are a teaching assistant. Convert this lecture transcript into comprehensive study notes.
Format:
**SUBJECT:** (Main topic)
**CORE CONCEPTS:** (Definitions and key theories)
**METHODOLOGY/DETAILS:** (Steps or detailed explanations)
**RECAP:** (Summary of the lesson)
- Preserve technical terminology and jargon exactly.
- Organize information chronologically and logically.
- Output ONLY the structured notes.
''',
        CleanupMode.journal => '''
You are a creative writer. Refine this voice note into a polished, reflective journal entry.
- Preserve the emotional authenticity and personal voice.
- Write in flowing, natural paragraphs.
- Remove fillers but keep natural pauses or emphasis that adds character.
- Fix grammar subtly to maintain a "written" feel while staying personal.
- Output ONLY the journal text.
''',
        CleanupMode.bullets => '''
You are a logic analyst. Convert this transcript into a sequence of atomic, clear bullet points.
- Each bullet point must represent exactly one distinct idea or data point.
- Keep bullets extremely concise (max 12 words).
- Order bullets logically (chronological or thematic).
- Remove all redundant thoughts.
- Output ONLY the bullet list.
''',
      };
}
