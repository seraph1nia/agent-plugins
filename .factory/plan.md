# Plan

1. Inspect `README.md` for the line or section intended to validate trace naming and identify the smallest wording change that satisfies the check.
2. Update only the relevant README text, preserving the existing marketplace/package description and any generated files unless the README edit reveals a required matching tweak.
3. Run the repo validation entrypoint, or at minimum the README-relevant checks, to confirm the wording change does not introduce manifest or marketplace drift.
4. Commit `.factory/context.md` and `.factory/plan.md` with the branch work once the plan is finalized.
