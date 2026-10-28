## 1.2.0
- New request options in `Configuration`: `tools`, `toolChoice`, `responseFormat`, `searchSettings`, `streamOptions`, `compoundCustom` and `citationOptions`, following the latest Groq API.
- `GroqResponse` exposes more of the API response: `serviceTier`, `systemFingerprint`, `usageBreakdown`, `mcpListTools` and `xGroq`; `GroqUsage` adds `queueTime` and prompt/completion token details.
- Documentation comments across the public API.
- More tolerant response parsing: whole-number timings, a missing `x_groq` block and `null` message content (tool calls) no longer throw.
- `toJson` fixes: `cached_tokens` key, nested `message`, and the new response fields.
- Tests for response parsing, plus an optional live test that runs when `GROQ_API_KEY` is set.

## 1.1.1
- Updated `README.md` file.

## 1.1.0
- Updated the Groq package to work with an configuration model to be able to configure more easly the api. 
- Updated the Groq example with the latest changes.
- Updated `.gitignore` file for better repository management.

## 1.0.0
- Replaced Enum with String Selection for Model to improve flexibility.
- Updated `.gitignore` file for better repository management.
- Enhanced README file with updated examples and additional details.

## 0.0.7
- Update example app

## 0.0.6
- Update AI models

## 0.0.5
- Update AI models
- Update example app

## 0.0.4
- Fix typo.

## 0.0.3
- Export Groq model.
- Add Gemma model.

## 0.0.2
- Fix warnings and package scores.

## 0.0.1

- Initial release.
