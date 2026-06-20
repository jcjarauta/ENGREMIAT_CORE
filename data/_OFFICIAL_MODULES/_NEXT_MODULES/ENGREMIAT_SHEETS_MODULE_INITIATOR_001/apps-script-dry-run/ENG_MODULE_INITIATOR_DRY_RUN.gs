function ENGREMIAT_generateModuleInitJsonDryRun(row) {
  const required = ["module_id","module_name","module_type","purpose","expected_output","priority","risk","requires_core_change","requires_real_write","requires_external_api","human_gate","status","decision"];
  const errors = [];
  required.forEach(function(k){ if (!row[k] || String(row[k]).trim() === "") errors.push("missing_" + k); });
  const boolFields = ["requires_core_change","requires_real_write","requires_external_api"];
  boolFields.forEach(function(k){ const v = String(row[k] || "").toUpperCase(); if (v !== "FALSE" && v !== "TRUE") errors.push("invalid_boolean_" + k); });
  const moduleId = String(row.module_id || "").trim();
  if (!/^ENGREMIAT_[A-Z0-9_]+_[0-9]{3}$/.test(moduleId)) errors.push("invalid_module_id_format");
  const targetPath = row.target_path && String(row.target_path).trim() !== "" ? String(row.target_path).trim() : "data/_OFFICIAL_MODULES/_NEXT_MODULES/" + moduleId;
  const payload = {
    module_id: moduleId,
    name: String(row.module_name || "").trim(),
    kind: String(row.module_type || "").trim(),
    status: "CANDIDATE",
    target_path: targetPath,
    purpose: String(row.purpose || "").trim(),
    problem: String(row.problem || "").trim(),
    expected_output: String(row.expected_output || "").trim(),
    source_task_packet_id: String(row.source_task_packet_id || "").trim(),
    priority: String(row.priority || "").trim(),
    risk: String(row.risk || "").trim(),
    dependencies: String(row.dependencies || "").split(",").map(function(x){return x.trim();}).filter(Boolean),
    gates: {
      human_gate: String(row.human_gate || "").trim(),
      requires_core_change: String(row.requires_core_change || "").toUpperCase() === "TRUE",
      requires_real_write: String(row.requires_real_write || "").toUpperCase() === "TRUE",
      requires_external_api: String(row.requires_external_api || "").toUpperCase() === "TRUE"
    },
    decision: String(row.decision || "").trim(),
    notes: String(row.notes || "").trim(),
    generated_by: "ENGREMIAT_SHEETS_MODULE_INITIATOR_001",
    generated_at: new Date().toISOString(),
    dry_run: true
  };
  return {
    validation_status: errors.length === 0 ? "PASS" : "ERR",
    validation_errors: errors,
    generated_json_log: JSON.stringify(payload, null, 2)
  };
}

