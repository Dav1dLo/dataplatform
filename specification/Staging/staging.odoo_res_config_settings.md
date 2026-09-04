# odoo_res_config_settings

## Source system
This table originates from Odoo ERP. It represents the core configuration and settings repository for an Odoo instance, capturing the state of various functional modules, feature toggles, and integration credentials (e.g., Twilio, Google, Stripe) managed through the Odoo "Settings" interface.

## Functional process 
This table supports the global system configuration and feature management process. It acts as the central registry for enabling or disabling business modules (e.g., CRM, Inventory, Accounting, POS) and defining global business rules, such as multi-currency support, invoice policies, and lead assignment strategies.

## Description
One row in this table represents a specific configuration snapshot for a company within the Odoo environment. It stores the current state of system-wide settings, including boolean flags for module activation, API keys for third-party integrations, and default operational parameters. This is a raw landed copy of the Odoo `res_config_settings` model, typically used to audit system changes or understand the functional scope of the ERP implementation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | Creator user ID | Reference to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to `res_users`. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC. |
| web_app_name | VARCHAR | true | Web application display name | |
| company_id | INTEGER | false | Company identifier | Reference to `res_company`. |
| user_default_rights | BOOLEAN | true | Default user rights enabled | |
| module_base_import | BOOLEAN | true | Base import module enabled | |
| module_google_calendar | BOOLEAN | true | Google Calendar integration | |
| module_microsoft_calendar | BOOLEAN | true | Microsoft Calendar integration | |
| module_mail_plugin | BOOLEAN | true | Mail plugin enabled | |
| module_auth_oauth | BOOLEAN | true | OAuth authentication enabled | |
| module_auth_ldap | BOOLEAN | true | LDAP authentication enabled | |
| module_account_inter_company_rules | BOOLEAN | true | Inter-company rules enabled | |
| module_voip | BOOLEAN | true | VoIP integration enabled | |
| module_web_unsplash | BOOLEAN | true | Unsplash integration enabled | |
| module_sms | BOOLEAN | true | SMS module enabled | |
| module_partner_autocomplete | BOOLEAN | true | Partner autocomplete enabled | |
| module_base_geolocalize | BOOLEAN | true | Geolocalization enabled | |
| module_google_recaptcha | BOOLEAN | true | Google reCAPTCHA enabled | |
| module_website_cf_turnstile | BOOLEAN | true | Cloudflare Turnstile enabled | |
| group_multi_currency | BOOLEAN | true | Multi-currency mode enabled | |
| show_effect | BOOLEAN | true | Show success effects | |
| module_product_images | BOOLEAN | true | Product images module enabled | |
| profiling_enabled_until | TIMESTAMP | true | Profiling expiration date | |
| recaptcha_public_key | VARCHAR | true | reCAPTCHA public key | Sensitive: Masking recommended. |
| recaptcha_private_key | VARCHAR | true | reCAPTCHA private key | Sensitive: Masking recommended. |
| recaptcha_min_score | DOUBLE PRECISION | true | reCAPTCHA minimum score | |
| tenor_gif_limit | INTEGER | true | Tenor GIF limit | |
| twilio_account_sid | VARCHAR | true | Twilio Account SID | Sensitive: Masking recommended. |
| twilio_account_token | VARCHAR | true | Twilio Account Token | Sensitive: Masking recommended. |
| sfu_server_url | VARCHAR | true | SFU server URL | |
| sfu_server_key | VARCHAR | true | SFU server key | Sensitive: Masking recommended. |
| tenor_api_key | VARCHAR | true | Tenor API key | Sensitive: Masking recommended. |
| tenor_content_filter | VARCHAR | true | Tenor content filter level | |
| google_translate_api_key | VARCHAR | true | Google Translate API key | Sensitive: Masking recommended. |
| external_email_server_default | BOOLEAN | true | Use external email server | |
| module_google_gmail | BOOLEAN | true | Gmail integration enabled | |
| module_microsoft_outlook | BOOLEAN | true | Outlook integration enabled | |
| restrict_template_rendering | BOOLEAN | true | Restrict template rendering | |
| use_twilio_rtc_servers | BOOLEAN | true | Use Twilio RTC servers | |
| group_analytic_accounting | BOOLEAN | true | Analytic accounting enabled | |
| auth_signup_template_user_id | INTEGER | true | Signup template user ID | |
| auth_signup_uninvited | VARCHAR | true | Signup uninvited policy | |
| auth_signup_reset_password | BOOLEAN | true | Reset password enabled | |
| google_gmail_client_identifier | VARCHAR | true | Gmail client ID | |
| google_gmail_client_secret | VARCHAR | true | Gmail client secret | Sensitive: Masking recommended. |
| product_weight_in_lbs | VARCHAR | true | Product weight unit (lbs) | |
| product_volume_volume_in_cubic_feet | VARCHAR | true | Product volume unit (cu ft) | |
| group_uom | BOOLEAN | true | Units of Measure enabled | |
| group_product_variant | BOOLEAN | true | Product variants enabled | |
| module_loyalty | BOOLEAN | true | Loyalty module enabled | |
| group_stock_packaging | BOOLEAN | true | Stock packaging enabled | |
| group_product_pricelist | BOOLEAN | true | Product pricelists enabled | |
| unsplash_access_key | VARCHAR | true | Unsplash access key | Sensitive: Masking recommended. |
| unsplash_app_id | VARCHAR | true | Unsplash app ID | |
| digest_id | INTEGER | true | Digest ID | |
| digest_emails | BOOLEAN | true | Digest emails enabled | |
| chart_template | VARCHAR | true | Accounting chart template | |
| module_account_accountant | BOOLEAN | true | Accountant module enabled | |
| group_warning_account | BOOLEAN | true | Accounting warnings enabled | |
| group_cash_rounding | BOOLEAN | true | Cash rounding enabled | |
| group_show_sale_receipts | BOOLEAN | true | Show sale receipts | |
| group_show_purchase_receipts | BOOLEAN | true | Show purchase receipts | |
| module_account_budget | BOOLEAN | true | Budget module enabled | |
| module_account_payment | BOOLEAN | true | Payment module enabled | |
| module_account_reports | BOOLEAN | true | Reports module enabled | |
| module_account_check_printing | BOOLEAN | true | Check printing enabled | |
| module_account_batch_payment | BOOLEAN | true | Batch payment enabled | |
| module_account_iso20022 | BOOLEAN | true | ISO 20022 enabled | |
| module_account_sepa_direct_debit | BOOLEAN | true | SEPA direct debit enabled | |
| module_account_bank_statement_import_qif | BOOLEAN | true | QIF import enabled | |
| module_account_bank_statement_import_ofx | BOOLEAN | true | OFX import enabled | |
| module_account_bank_statement_import_csv | BOOLEAN | true | CSV import enabled | |
| module_account_bank_statement_import_camt | BOOLEAN | true | CAMT import enabled | |
| module_currency_rate_live | BOOLEAN | true | Live currency rates enabled | |
| module_account_intrastat | BOOLEAN | true | Intrastat enabled | |
| module_product_margin | BOOLEAN | true | Product margin enabled | |
| module_l10n_eu_oss | BOOLEAN | true | EU OSS enabled | |
| module_account_extract | BOOLEAN | true | Account extract enabled | |
| module_account_invoice_extract | BOOLEAN | true | Invoice extract enabled | |
| module_account_bank_statement_extract | BOOLEAN | true | Bank statement extract enabled | |
| module_snailmail_account | BOOLEAN | true | Snailmail enabled | |
| module_account_peppol | BOOLEAN | true | Peppol enabled | |
| use_invoice_terms | BOOLEAN | true | Invoice terms enabled | |
| group_sale_delivery_address | BOOLEAN | true | Sale delivery address enabled | |
| crm_auto_assignment_interval_number | INTEGER | true | Auto-assignment interval | |
| crm_auto_assignment_action | VARCHAR | true | Auto-assignment action | |
| crm_auto_assignment_interval_type | VARCHAR | true | Auto-assignment interval type | |
| lead_enrich_auto | VARCHAR | true | Lead enrichment policy | |
| predictive_lead_scoring_start_date_str | VARCHAR | true | Lead scoring start date | |
| predictive_lead_scoring_fields_str | VARCHAR | true | Lead scoring fields | |
| group_use_lead | BOOLEAN | true | Use leads enabled | |
| group_use_recurring_revenues | BOOLEAN | true | Recurring revenue enabled | |
| is_membership_multi | BOOLEAN | true | Multi-membership enabled | |
| crm_use_auto_assignment | BOOLEAN | true | Auto-assignment enabled | |
| module_crm_iap_mine | BOOLEAN | true | CRM IAP Mine enabled | |
| module_crm_iap_enrich | BOOLEAN | true | CRM IAP Enrich enabled | |
| module_website_crm_iap_reveal | BOOLEAN | true | Website CRM IAP Reveal enabled | |
| lead_mining_in_pipeline | BOOLEAN | true | Lead mining in pipeline | |
| crm_auto_assignment_run_datetime | TIMESTAMP | true | Last auto-assignment run | |
| module_hr_presence | BOOLEAN | true | HR presence enabled | |
| module_hr_skills | BOOLEAN | true | HR skills enabled | |
| module_hr_homeworking | BOOLEAN | true | HR homeworking enabled | |
| hr_employee_self_edit | BOOLEAN | true | Employee self-edit enabled | |
| module_hr_timesheet | BOOLEAN | true | HR timesheet enabled | |
| group_project_rating | BOOLEAN | true | Project rating enabled | |
| group_project_stages | BOOLEAN | true | Project stages enabled | |
| group_project_recurring_tasks | BOOLEAN | true | Recurring tasks enabled | |
| group_project_task_dependencies | BOOLEAN | true | Task dependencies enabled | |
| group_project_milestone | BOOLEAN | true | Project milestones enabled | |
| barcode_separator | VARCHAR | true | Barcode separator character | |
| module_product_expiry | BOOLEAN | true | Product expiry enabled | |
| group_stock_production_lot | BOOLEAN | true | Production lots enabled | |
| group_stock_lot_print_gs1 | BOOLEAN | true | GS1 lot printing enabled | |
| group_lot_on_delivery_slip | BOOLEAN | true | Lot on delivery slip enabled | |
| group_stock_tracking_lot | BOOLEAN | true | Tracking lots enabled | |
| group_stock_tracking_owner | BOOLEAN | true | Tracking owners enabled | |
| group_stock_adv_location | BOOLEAN | true | Advanced locations enabled | |
| group_warning_stock | BOOLEAN | true | Stock warnings enabled | |
| group_stock_sign_delivery | BOOLEAN | true | Sign delivery enabled | |
| module_stock_picking_batch | BOOLEAN | true | Batch picking enabled | |
| module_stock_barcode | BOOLEAN | true | Stock barcode enabled | |
| module_stock_barcode_barcodelookup | BOOLEAN | true | Barcode lookup enabled | |
| module_stock_sms | BOOLEAN | true | Stock SMS enabled | |
| module_delivery | BOOLEAN | true | Delivery module enabled | |
| module_delivery_dhl | BOOLEAN | true | DHL integration enabled | |
| module_delivery_fedex | BOOLEAN | true | FedEx integration enabled | |
| module_delivery_ups | BOOLEAN | true | UPS integration enabled | |
| module_delivery_usps | BOOLEAN | true | USPS integration enabled | |
| module_delivery_bpost | BOOLEAN | true | Bpost integration enabled | |
| module_delivery_easypost | BOOLEAN | true | EasyPost integration enabled | |
| module_delivery_sendcloud | BOOLEAN | true | Sendcloud integration enabled | |
| module_delivery_shiprocket | BOOLEAN | true | Shiprocket integration enabled | |
| module_delivery_starshipit | BOOLEAN | true | Starshipit integration enabled | |
| module_quality_control | BOOLEAN | true | Quality control enabled | |
| module_quality_control_worksheet | BOOLEAN | true | Quality worksheet enabled | |
| group_stock_multi_locations | BOOLEAN | true | Multi-locations enabled | |
| group_stock_reception_report | BOOLEAN | true | Reception report enabled | |
| module_stock_dropshipping | BOOLEAN | true | Dropshipping enabled | |
| module_stock_fleet | BOOLEAN | true | Stock fleet enabled | |
| website_id | INTEGER | true | Website identifier | |
| group_multi_website | BOOLEAN | true | Multi-website enabled | |
| module_website_livechat | BOOLEAN | true | Livechat enabled | |
| module_marketing_automation | BOOLEAN | true | Marketing automation enabled | |
| pay_invoices_online | BOOLEAN | true | Online invoice payment enabled | |
| use_manufacturing_lead | BOOLEAN | true | Manufacturing lead enabled | |
| group_mrp_byproducts | BOOLEAN | true | Byproducts enabled | |
| module_mrp_mps | BOOLEAN | true | MPS enabled | |
| module_mrp_plm | BOOLEAN | true | PLM enabled | |
| module_mrp_subcontracting | BOOLEAN | true | Subcontracting enabled | |
| group_mrp_routings | BOOLEAN | true | Routings enabled | |
| group_unlocked_by_default | BOOLEAN | true | Unlocked by default | |
| group_mrp_reception_report | BOOLEAN | true | MRP reception report enabled | |
| group_mrp_workorder_dependencies | BOOLEAN | true | Workorder dependencies enabled | |
| default_purchase_method | VARCHAR | true | Default purchase method | |
| lock_confirmed_po | BOOLEAN | true | Lock confirmed POs | |
| po_order_approval | BOOLEAN | true | PO approval enabled | |
| group_warning_purchase | BOOLEAN | true | Purchase warnings enabled | |
| module_account_3way_match | BOOLEAN | true | 3-way match enabled | |
| module_purchase_requisition | BOOLEAN | true | Purchase requisition enabled | |
| module_purchase_product_matrix | BOOLEAN | true | Product matrix enabled | |
| use_po_lead | BOOLEAN | true | Use PO lead time | |
| group_send_reminder | BOOLEAN | true | Send reminders enabled | |
| module_stock_landed_costs | BOOLEAN | true | Landed costs enabled | |
| group_lot_on_invoice | BOOLEAN | true | Lot on invoice enabled | |
| group_stock_accounting_automatic | BOOLEAN | true | Automatic stock accounting | |
| pos_config_id | INTEGER | true | POS configuration ID | |
| pos_default_fiscal_position_id | INTEGER | true | Default fiscal position ID | |
| pos_pricelist_id | INTEGER | true | POS pricelist ID | |
| pos_tip_product_id | INTEGER | true | POS tip product ID | |
| pos_receipt_footer | TEXT | true | POS receipt footer text | |
| pos_receipt_header | TEXT | true | POS receipt header text | |
| module_pos_adyen | BOOLEAN | true | Adyen POS enabled | |
| module_pos_stripe | BOOLEAN | true | Stripe POS enabled | |
| module_pos_six | BOOLEAN | true | Six POS enabled | |
| module_pos_viva_wallet | BOOLEAN | true | Viva Wallet POS enabled | |
| module_pos_paytm | BOOLEAN | true | Paytm POS enabled | |
| module_pos_razorpay | BOOLEAN | true | Razorpay POS enabled | |
| module_pos_mercado_pago | BOOLEAN | true | Mercado Pago POS enabled | |
| module_pos_preparation_display | BOOLEAN | true | Preparation display enabled | |
| module_pos_pricer | BOOLEAN | true | Pricer enabled | |
| is_kiosk_mode | BOOLEAN | true | Kiosk mode enabled | |
| pos_is_order_printer | BOOLEAN | true | Order printer enabled | |
| pos_iface_cashdrawer