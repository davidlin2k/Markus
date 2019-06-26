# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_21_203403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotation_categories", id: :serial, force: :cascade do |t|
    t.text "annotation_category_name"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "assignment_id", null: false
    t.integer "annotation_texts_count", default: 0
    t.index ["assignment_id"], name: "index_annotation_categories_on_assignment_id"
  end

  create_table "annotation_texts", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "annotation_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
    t.integer "last_editor_id"
    t.index ["annotation_category_id"], name: "index_annotation_texts_on_annotation_category_id"
  end

  create_table "annotations", id: :serial, force: :cascade do |t|
    t.integer "line_start"
    t.integer "line_end"
    t.integer "annotation_text_id"
    t.integer "submission_file_id"
    t.integer "x1"
    t.integer "x2"
    t.integer "y1"
    t.integer "y2"
    t.string "type"
    t.integer "annotation_number"
    t.boolean "is_remark"
    t.integer "page"
    t.integer "column_start"
    t.integer "column_end"
    t.integer "creator_id"
    t.string "creator_type"
    t.integer "result_id"
    t.index ["creator_type", "creator_id"], name: "index_annotations_on_creator_type_and_creator_id"
    t.index ["submission_file_id"], name: "index_annotations_on_submission_file_id"
  end

  create_table "assignment_files", id: :serial, force: :cascade do |t|
    t.integer "assignment_id"
    t.string "filename", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assignment_id", "filename"], name: "index_assignment_files_on_assignment_id_and_filename", unique: true
    t.index ["assignment_id"], name: "index_assignment_files_on_assignment_id"
  end

  create_table "assignment_stats", id: :serial, force: :cascade do |t|
    t.integer "assignment_id"
    t.text "grade_distribution_percentage"
  end

  create_table "assignments", id: :serial, force: :cascade do |t|
    t.string "short_identifier", null: false
    t.string "description"
    t.text "message"
    t.datetime "due_date"
    t.integer "group_min", default: 1, null: false
    t.integer "group_max", default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "student_form_groups", default: false, null: false
    t.boolean "group_name_autogenerated", default: true, null: false
    t.boolean "group_name_displayed", default: false, null: false
    t.string "repository_folder", null: false
    t.boolean "invalid_override", default: false, null: false
    t.float "results_average"
    t.boolean "allow_web_submits", default: true, null: false
    t.boolean "section_groups_only", default: false, null: false
    t.boolean "section_due_dates_type", default: false, null: false
    t.boolean "display_grader_names_to_students", default: false, null: false
    t.boolean "enable_test", default: false, null: false
    t.integer "notes_count", default: 0
    t.boolean "assign_graders_to_criteria", default: false, null: false
    t.integer "rubric_criteria_count"
    t.integer "flexible_criteria_count"
    t.integer "groupings_count"
    t.integer "tokens_per_period", default: 0, null: false
    t.boolean "allow_remarks", default: false, null: false
    t.datetime "remark_due_date"
    t.text "remark_message"
    t.float "results_median"
    t.integer "results_fails"
    t.integer "results_zeros"
    t.integer "outstanding_remark_request_count"
    t.boolean "unlimited_tokens", default: false, null: false
    t.boolean "is_hidden", default: false, null: false
    t.boolean "only_required_files", default: false, null: false
    t.boolean "vcs_submit", default: false, null: false
    t.datetime "token_start_date"
    t.float "token_period"
    t.integer "parent_assignment_id"
    t.boolean "has_peer_review", default: false, null: false
    t.integer "checkbox_criteria_count"
    t.boolean "enable_student_tests", default: false, null: false
    t.boolean "non_regenerating_tokens", default: false, null: false
    t.boolean "scanned_exam", default: false, null: false
    t.boolean "display_median_to_students", default: false, null: false
    t.index ["short_identifier"], name: "index_assignments_on_short_identifier", unique: true
  end

  create_table "checkbox_criteria", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "position"
    t.integer "assignment_id", null: false
    t.decimal "max_mark", precision: 10, scale: 1
    t.integer "assigned_groups_count", default: 0
    t.boolean "ta_visible", default: true, null: false
    t.boolean "peer_visible", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id", "name"], name: "index_checkbox_criteria_on_assignment_id_and_name", unique: true
  end

  create_table "criteria_assignment_files_joins", id: :serial, force: :cascade do |t|
    t.integer "criterion_id", null: false
    t.string "criterion_type", null: false
    t.integer "assignment_file_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "criterion_ta_associations", id: :serial, force: :cascade do |t|
    t.integer "ta_id"
    t.integer "criterion_id"
    t.string "criterion_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "assignment_id"
    t.index ["criterion_id"], name: "index_criterion_ta_associations_on_criterion_id"
    t.index ["ta_id"], name: "index_criterion_ta_associations_on_ta_id"
  end

  create_table "exam_templates", id: :serial, force: :cascade do |t|
    t.integer "assignment_id"
    t.string "filename", null: false
    t.integer "num_pages", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "cover_fields", default: "", null: false
    t.boolean "automatic_parsing", default: false, null: false
    t.decimal "crop_x"
    t.decimal "crop_y"
    t.decimal "crop_width"
    t.decimal "crop_height"
    t.index ["assignment_id"], name: "index_exam_templates_on_assignment_id"
  end

  create_table "extensions", force: :cascade do |t|
    t.string "time_delta", null: false
    t.boolean "apply_penalty", default: false, null: false
    t.bigint "grouping_id", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grouping_id"], name: "index_extensions_on_grouping_id", unique: true
  end

  create_table "extra_marks", id: :serial, force: :cascade do |t|
    t.integer "result_id"
    t.string "description"
    t.float "extra_mark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "unit"
    t.index ["result_id"], name: "index_extra_marks_on_result_id"
  end

  create_table "feedback_files", id: :serial, force: :cascade do |t|
    t.string "filename", null: false
    t.binary "file_content", null: false
    t.string "mime_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.index ["submission_id"], name: "index_feedback_files_on_submission_id"
  end

  create_table "flexible_criteria", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "position"
    t.integer "assignment_id", null: false
    t.decimal "max_mark", precision: 10, scale: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "assigned_groups_count", default: 0
    t.boolean "ta_visible", default: true, null: false
    t.boolean "peer_visible", default: false, null: false
    t.index ["assignment_id", "name"], name: "index_flexible_criteria_on_assignment_id_and_name", unique: true
    t.index ["assignment_id"], name: "index_flexible_criteria_on_assignment_id"
  end

  create_table "grace_period_deductions", id: :serial, force: :cascade do |t|
    t.integer "membership_id"
    t.integer "deduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["membership_id"], name: "index_grace_period_deductions_on_membership_id"
  end

  create_table "grade_entry_forms", id: :serial, force: :cascade do |t|
    t.string "short_identifier", null: false
    t.string "description"
    t.text "message"
    t.date "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "show_total"
    t.boolean "is_hidden"
    t.index ["short_identifier"], name: "index_grade_entry_forms_on_short_identifier", unique: true
  end

  create_table "grade_entry_items", id: :serial, force: :cascade do |t|
    t.integer "grade_entry_form_id"
    t.string "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "out_of"
    t.integer "position"
    t.boolean "bonus", default: false
    t.index ["grade_entry_form_id", "name"], name: "index_grade_entry_items_on_grade_entry_form_id_and_name", unique: true
  end

  create_table "grade_entry_students", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "grade_entry_form_id"
    t.boolean "released_to_student"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "total_grade"
    t.index ["user_id", "grade_entry_form_id"], name: "index_grade_entry_students_on_user_id_and_grade_entry_form_id", unique: true
  end

  create_table "grade_entry_students_tas", id: :serial, force: :cascade do |t|
    t.integer "grade_entry_student_id"
    t.integer "ta_id"
  end

  create_table "grades", id: :serial, force: :cascade do |t|
    t.integer "grade_entry_item_id"
    t.integer "grade_entry_student_id"
    t.float "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["grade_entry_item_id", "grade_entry_student_id"], name: "index_grades_on_grade_entry_item_id_and_grade_entry_student_id", unique: true
  end

  create_table "groupings", id: :serial, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "assignment_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "admin_approved", default: false, null: false
    t.boolean "is_collected", default: false
    t.integer "notes_count", default: 0
    t.integer "criteria_coverage_count", default: 0
    t.integer "test_tokens", default: 0, null: false
    t.text "starter_code_revision_identifier"
    t.index ["assignment_id", "group_id"], name: "groupings_u1", unique: true
  end

  create_table "groupings_tags", id: false, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "grouping_id", null: false
    t.index ["tag_id", "grouping_id"], name: "index_groupings_tags_on_tag_id_and_grouping_id", unique: true
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "group_name", limit: 30
    t.string "repo_name"
    t.index ["group_name"], name: "groups_name_unique", unique: true
  end

  create_table "job_messengers", id: :serial, force: :cascade do |t|
    t.string "job_id"
    t.string "status"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_messengers_on_job_id"
  end

  create_table "key_pairs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "user_name"
    t.string "file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marking_schemes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marking_weights", id: :serial, force: :cascade do |t|
    t.integer "marking_scheme_id"
    t.integer "gradable_item_id"
    t.decimal "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_assignment", null: false
  end

  create_table "marks", id: :serial, force: :cascade do |t|
    t.integer "result_id"
    t.integer "markable_id"
    t.float "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "markable_type"
    t.index ["markable_id", "result_id", "markable_type"], name: "marks_u1", unique: true
    t.index ["markable_id"], name: "index_marks_on_markable_id"
    t.index ["result_id"], name: "index_marks_on_result_id"
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "membership_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "grouping_id", null: false
    t.string "type"
    t.index ["grouping_id", "user_id"], name: "memberships_u1", unique: true
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.text "notes_message", null: false
    t.integer "creator_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "noteable_id", null: false
    t.string "noteable_type", null: false
    t.index ["creator_id"], name: "index_notes_on_creator_id"
  end

  create_table "peer_reviews", id: :serial, force: :cascade do |t|
    t.integer "result_id", null: false
    t.integer "reviewer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id", "reviewer_id"], name: "index_peer_reviews_on_result_id_and_reviewer_id", unique: true
    t.index ["result_id"], name: "index_peer_reviews_on_result_id"
    t.index ["reviewer_id"], name: "index_peer_reviews_on_reviewer_id"
  end

  create_table "periods", id: :serial, force: :cascade do |t|
    t.integer "submission_rule_id"
    t.float "deduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "hours"
    t.float "interval"
    t.string "submission_rule_type"
    t.index ["submission_rule_id"], name: "index_periods_on_submission_rule_id"
  end

  create_table "results", id: :serial, force: :cascade do |t|
    t.integer "submission_id"
    t.string "marking_state"
    t.text "overall_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "released_to_students", default: false, null: false
    t.float "total_mark", default: 0.0
    t.datetime "remark_request_submitted_at"
    t.integer "peer_review_id"
    t.index ["peer_review_id"], name: "index_results_on_peer_review_id"
  end

  create_table "rubric_criteria", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "assignment_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
    t.text "level_0_name"
    t.text "level_0_description"
    t.text "level_1_name"
    t.text "level_1_description"
    t.text "level_2_name"
    t.text "level_2_description"
    t.text "level_3_name"
    t.text "level_3_description"
    t.text "level_4_name"
    t.text "level_4_description"
    t.decimal "max_mark", precision: 10, scale: 1, null: false
    t.integer "assigned_groups_count", default: 0
    t.boolean "ta_visible", default: true, null: false
    t.boolean "peer_visible", default: false, null: false
    t.index ["assignment_id", "name"], name: "rubric_critera_index_1", unique: true
  end

  create_table "section_due_dates", id: :serial, force: :cascade do |t|
    t.datetime "due_date"
    t.integer "section_id"
    t.integer "assignment_id"
  end

  create_table "sections", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "split_pages", id: :serial, force: :cascade do |t|
    t.integer "raw_page_number"
    t.integer "exam_page_number"
    t.string "filename"
    t.string "status"
    t.integer "split_pdf_log_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_split_pages_on_group_id"
    t.index ["split_pdf_log_id"], name: "index_split_pages_on_split_pdf_log_id"
  end

  create_table "split_pdf_logs", id: :serial, force: :cascade do |t|
    t.datetime "uploaded_when"
    t.string "error_description"
    t.string "filename"
    t.integer "user_id"
    t.integer "num_groups_in_complete"
    t.integer "num_groups_in_incomplete"
    t.integer "num_pages_qr_scan_error"
    t.integer "original_num_pages"
    t.boolean "qr_code_found"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exam_template_id"
    t.index ["exam_template_id"], name: "index_split_pdf_logs_on_exam_template_id"
    t.index ["user_id"], name: "index_split_pdf_logs_on_user_id"
  end

  create_table "submission_files", id: :serial, force: :cascade do |t|
    t.integer "submission_id"
    t.string "filename"
    t.string "path", default: "/", null: false
    t.boolean "is_converted", default: false
    t.boolean "error_converting", default: false
    t.index ["filename"], name: "index_submission_files_on_filename"
    t.index ["submission_id"], name: "index_submission_files_on_submission_id"
  end

  create_table "submission_rules", id: :serial, force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.string "type", default: "NoLateSubmissionRule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assignment_id"], name: "index_submission_rules_on_assignment_id"
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.integer "grouping_id"
    t.datetime "created_at"
    t.integer "submission_version"
    t.boolean "submission_version_used"
    t.text "revision_identifier"
    t.datetime "revision_timestamp"
    t.text "remark_request"
    t.datetime "remark_request_timestamp"
    t.index ["grouping_id"], name: "index_submissions_on_grouping_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "user_id"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "template_divisions", id: :serial, force: :cascade do |t|
    t.integer "exam_template_id"
    t.integer "start", null: false
    t.integer "end", null: false
    t.string "label", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assignment_file_id"
    t.index ["exam_template_id"], name: "index_template_divisions_on_exam_template_id"
  end

  create_table "test_batches", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_group_results", id: :serial, force: :cascade do |t|
    t.integer "test_group_id"
    t.float "marks_earned", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "time", null: false
    t.float "marks_total", default: 0.0, null: false
    t.integer "test_run_id", null: false
    t.text "extra_info"
    t.index ["test_run_id"], name: "index_test_group_results_on_test_run_id"
  end

  create_table "test_groups", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.integer "display_output", default: 0, null: false
    t.bigint "assignment_id", null: false
    t.string "criterion_type"
    t.bigint "criterion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_test_groups_on_assignment_id"
    t.index ["criterion_type", "criterion_id"], name: "index_test_groups_on_criterion_type_and_criterion_id"
  end

  create_table "test_results", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.text "status", null: false
    t.float "marks_earned", default: 0.0, null: false
    t.text "output", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "marks_total", default: 0.0, null: false
    t.bigint "time"
    t.bigint "test_group_result_id", null: false
    t.index ["test_group_result_id"], name: "index_test_results_on_test_group_result_id"
  end

  create_table "test_runs", id: :serial, force: :cascade do |t|
    t.bigint "time_to_service_estimate"
    t.bigint "time_to_service"
    t.integer "test_batch_id"
    t.integer "grouping_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "submission_id"
    t.text "revision_identifier"
    t.text "problems"
    t.index ["grouping_id"], name: "index_test_runs_on_grouping_id"
    t.index ["submission_id"], name: "index_test_runs_on_submission_id"
    t.index ["test_batch_id"], name: "index_test_runs_on_test_batch_id"
    t.index ["user_id"], name: "index_test_runs_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "user_name", null: false
    t.string "last_name"
    t.string "first_name"
    t.integer "grace_credits", default: 0, null: false
    t.string "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "hidden", default: false, null: false
    t.string "api_key"
    t.integer "section_id"
    t.integer "notes_count", default: 0
    t.string "email"
    t.string "id_number"
    t.index ["api_key"], name: "index_users_on_api_key", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "annotation_texts", "annotation_categories", name: "fk_annotation_labels_annotation_categories", on_delete: :cascade
  add_foreign_key "annotations", "annotation_texts", name: "fk_annotations_annotation_texts"
  add_foreign_key "annotations", "submission_files", name: "fk_annotations_submission_files"
  add_foreign_key "assignment_files", "assignments", name: "fk_assignment_files_assignments", on_delete: :cascade
  add_foreign_key "assignment_stats", "assignments", name: "fk_assignment_stats_assignments", on_delete: :cascade
  add_foreign_key "checkbox_criteria", "assignments"
  add_foreign_key "criteria_assignment_files_joins", "assignment_files"
  add_foreign_key "exam_templates", "assignments"
  add_foreign_key "extensions", "groupings"
  add_foreign_key "extra_marks", "results", name: "fk_extra_marks_results", on_delete: :cascade
  add_foreign_key "feedback_files", "submissions"
  add_foreign_key "groupings", "assignments", name: "fk_groupings_assignments"
  add_foreign_key "groupings", "groups", name: "fk_groupings_groups"
  add_foreign_key "marks", "results", name: "fk_marks_results", on_delete: :cascade
  add_foreign_key "memberships", "groupings", name: "fk_memberships_groupings"
  add_foreign_key "memberships", "users", name: "fk_memberships_users"
  add_foreign_key "peer_reviews", "groupings", column: "reviewer_id"
  add_foreign_key "peer_reviews", "results"
  add_foreign_key "results", "peer_reviews", on_delete: :cascade
  add_foreign_key "results", "submissions", name: "fk_results_submissions", on_delete: :cascade
  add_foreign_key "rubric_criteria", "assignments", name: "fk_rubric_criteria_assignments", on_delete: :cascade
  add_foreign_key "split_pages", "groups"
  add_foreign_key "split_pages", "split_pdf_logs"
  add_foreign_key "split_pdf_logs", "exam_templates"
  add_foreign_key "split_pdf_logs", "users"
  add_foreign_key "submission_files", "submissions", name: "fk_submission_files_submissions"
  add_foreign_key "tags", "users"
  add_foreign_key "template_divisions", "assignment_files"
  add_foreign_key "template_divisions", "exam_templates"
  add_foreign_key "test_group_results", "test_runs"
  add_foreign_key "test_groups", "assignments"
  add_foreign_key "test_results", "test_group_results"
  add_foreign_key "test_runs", "groupings"
  add_foreign_key "test_runs", "submissions"
  add_foreign_key "test_runs", "test_batches"
  add_foreign_key "test_runs", "users"
end
