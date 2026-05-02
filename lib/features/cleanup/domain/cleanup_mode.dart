enum CleanupMode { clean, meeting, lecture, journal, bullets }

extension CleanupModeExtension on CleanupMode {
  String get label => switch (this) {
    CleanupMode.clean => 'Clean Up',
    CleanupMode.meeting => 'Meeting Notes',
    CleanupMode.lecture => 'Lecture Notes',
    CleanupMode.journal => 'Journal Entry',
    CleanupMode.bullets => 'Bullet Points',
  };

  String get description => switch (this) {
    CleanupMode.clean => 'Fix grammar, remove fillers',
    CleanupMode.meeting => 'Action items + decisions',
    CleanupMode.lecture => 'Key concepts + structure',
    CleanupMode.journal => 'Personal, reflective tone',
    CleanupMode.bullets => 'Concise bullet points',
  };
  String get icon => switch (this) {
    CleanupMode.clean => '✨',
    CleanupMode.meeting => '📋',
    CleanupMode.lecture => '🎓',
    CleanupMode.journal => '📔',
    CleanupMode.bullets => '•',
  };


  String get prompt => switch (this) {
        CleanupMode.clean => '''
You are a transcript editor. Clean up the following raw voice transcript.
- Remove filler words (uh, um, like, you know, basically, literally, right)
- Fix grammar and punctuation
- Remove repetitions and false starts
- Keep the original meaning and tone exactly
- Make it readable as written text
- Do not add information that wasn't said
- Return only the cleaned text, nothing else
''',
        CleanupMode.meeting => '''
You are a meeting notes specialist. Convert this raw meeting transcript into structured notes.
Format:
**Summary:** (2-3 sentences of what was discussed)
**Decisions Made:** (bullet list, only if any were made)
**Action Items:** (bullet list with owner if mentioned, only if any exist)
**Key Points:** (bullet list of important topics)
- Remove all filler words and informal speech
- Be concise and professional
- Return only the formatted notes, nothing else
''',
        CleanupMode.lecture => '''
You are an academic note-taker. Convert this lecture transcript into structured study notes.
Format:
**Topic:** (main subject)
**Key Concepts:** (bullet list of main ideas)
**Details & Explanations:** (organized paragraphs)
**Summary:** (3-4 sentence recap)
- Preserve technical terms exactly as said
- Organize logically even if the speaker jumped around
- Return only the formatted notes, nothing else
''',
        CleanupMode.journal => '''
You are a journal writing assistant. Convert this voice note into a personal journal entry.
- Write in first person
- Keep the personal, reflective tone
- Fix grammar but preserve the speaker's voice
- Organize thoughts into flowing paragraphs
- Remove filler words but keep emotional authenticity
- Return only the journal entry text, nothing else
''',
        CleanupMode.bullets => '''
You are a concise note-taker. Convert this transcript into clear bullet points.
- Extract every distinct idea or point
- Each bullet should be one clear, complete thought
- Remove all filler words and repetition
- Keep bullets short (under 15 words each)
- Preserve all important information
- Return only the bullet points, nothing else
''',
      };
}
