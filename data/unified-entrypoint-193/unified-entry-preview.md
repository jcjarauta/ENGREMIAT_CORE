UNIFIED ENTRY PREVIEW

Objective: DEFINE_UNIFIED_ENTRYPOINT_PLAN_LAUNCHER_MVP_192_195
Stage: E193

Summary:
- Plan intake and reusable launcher are unified into one entry point.

Candidate:
- 
UNIFIED_ENTRY_SAMPLE_001
- 
Sample plan to validate the unified entry point

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
- Make the entry point easy to read before any write step.
- Keep the route from plan to launcher obvious.
