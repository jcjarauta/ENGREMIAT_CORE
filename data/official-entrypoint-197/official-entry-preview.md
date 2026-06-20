OFFICIAL ENTRY PREVIEW

Objective: DEFINE_UNIFIED_ENTRYPOINT_OFFICIAL_INGRESS_MVP
Stage: E197

Summary:
- Plan intake and reusable launcher are now treated as the official ingress.

Candidate:
- OFFICIAL_ENTRY_SAMPLE_001
- Sample plan to validate the official ingress

States:
- received
- normalized
- validated
- approved
- ready_for_launcher
- handoff_created
- closed

Fields:
- objective_id
- context
- goal
- inputs
- outputs
- restrictions
- risk_level
- authorization_required
- handoff_to_launcher
- close_criteria
- next_step

Readonly UX goal:
- Make the official entry point easy to read before any write step.
- Keep the route from plan to launcher obvious.
