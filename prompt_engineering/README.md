# Summary

This folder contains a set of files designed to facilitate **recursive self-improvement** of a Large Language Model (LLM) through prompt engineering on a given topic. The core idea is to establish a pipeline for creating optimized prompts for any task.

---

## File Structure and Pipeline

### 00_pseudo_system_prompt.md

This file serves as a **pseudo-system prompt** for the LLM. It provides general instructions for prompt engineering, an overview of the project, expected LLM behavior, and essential guidelines. It offers a foundational understanding of the project. **The LLM should never edit this file** unless the specific task is to improve the file itself.

### 01_sloppy_prompt_only_user_can_edit.md

This file is **exclusively for developer edits**. It captures the developer's initial intentions for the next prompt engineering task. The prompt can be a rough draft, containing grammatical errors or multiple iterations. **The LLM is never to edit this file.**

### 02_grammar_corrected_prompt_llm_must_edit.md

This is the **initial step in our recursive self-improvement pipeline**. An LLM will edit this file by taking the content from `01_sloppy_prompt_only_user_can_edit.md` and correcting all grammar and spelling mistakes. It will also refine the text for improved precision and readability.

---

## Recursive Self-Improvement Stage

Following the grammar correction, we enter the crucial **recursive self-improvement stage**. Here, the LLM is expected to generate high-quality prompts that maximize the user's intended task, as outlined in `01_sloppy_prompt_only_user_can_edit.md`. This involves the following files:

* **03_prompt_engineering_level_01_llm_must_edit.md**
* **04_prompt_engineering_level_02_llm_must_edit.md**

While the recursive loop could theoretically go deeper, there's a significant risk: if the prompt continuously "improves" indefinitely, the LLM might start to **hallucinate new objectives and side goals** in an attempt to "make things better overall," which is not the intent. The primary goal is to understand the user's original intent and craft the best possible, highly precise prompt that, when executed, has a high chance of success.

Should a user desire further prompt refinement, they can simply take the content from `04_prompt_engineering_level_02_llm_must_edit.md` and use it as the new `01_sloppy_prompt_only_user_can_edit.md` to restart the improvement flow.

---

## Final Stage: Critical Analysis

### 05_self_assessment_final_prompt_vs_original_user_prompt.md

This crucial file facilitates a **comparison between the initial prompt** (`01_sloppy_prompt_only_user_can_edit.md`) **and the final engineered prompt** (`04_prompt_engineering_level_02_llm_must_edit.md`).

This stage forces the LLM to **verify its work** against the original user prompt. The LLM must ensure that it **did not hallucinate new objectives or goals** that were never stated. It needs to confirm that it accurately understood the user's requirements and crafted a precise, well-structured prompt that will likely achieve the user's goals when fed into a coding agent for execution.