// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

using System.DateTime;
using System.Telemetry;

table 5265 "Audit File Export Header"
{
    DataClassification = CustomerContent;
    Caption = 'Audit File Export Header';
    LookupPageId = "Audit File Export Documents";
    DrillDownPageId = "Audit File Export Documents";

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "G/L Account Mapping Code"; Code[20])
        {
            Caption = 'G/L Account Mapping Code';
            TableRelation = "G/L Account Mapping Header" where("Audit File Export Format" = field("Audit File Export Format"));

            trigger OnValidate()
            var
                GLAccountMappingHeader: Record "G/L Account Mapping Header";
            begin
                if "G/L Account Mapping Code" = '' then begin
                    Validate("Starting Date", 0D);
                    Validate("Ending Date", 0D);
                end else begin
                    GLAccountMappingHeader.Get("G/L Account Mapping Code");
                    Validate("Starting Date", GLAccountMappingHeader."Starting Date");
                    Validate("Ending Date", GLAccountMappingHeader."Ending Date");
                end;
            end;
        }
        field(3; "Audit File Export Format"; Enum "Audit File Export Format")
        {
            Caption = 'Audit File Export Format';

            trigger OnValidate()
            var
                AuditFileExportFormatSetup: Record "Audit File Export Format Setup";
            begin
                if AuditFileExportFormatSetup.Get(Rec."Audit File Export Format") then begin
                    Rec."Archive to Zip" := AuditFileExportFormatSetup."Archive to Zip";
                    Rec."Audit File Name" := AuditFileExportFormatSetup."Audit File Name";
                end;
            end;
        }
        field(4; "Audit File Name"; Text[1024])
        {
            Caption = 'Audit File Name';
        }
        field(5; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(6; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(10; "Header Comment"; Text[250])
        {
            Caption = 'Header Comment';
        }
        field(11; Contact; Text[250])
        {
            Caption = 'Contact';
        }
        field(15; "Split By Month"; Boolean)
        {
            Caption = 'Split By Month';
            InitValue = true;

            trigger OnValidate()
            begin
                if "Split By Month" then
                    "Split By Date" := false;
            end;
        }
        field(16; "Split By Date"; Boolean)
        {
            Caption = 'Split By Date';

            trigger OnValidate()
            begin
                if "Split By Date" then
                    "Split By Month" := false;
            end;
        }
        field(17; "Archive to Zip"; Boolean)
        {
            Caption = 'Archive to Zip';

            trigger OnValidate()
            begin
                if not "Archive to Zip" then
                    "Create Multiple Zip Files" := false;
            end;
        }
        field(18; "Create Multiple Zip Files"; Boolean)
        {
            Caption = 'Create Multiple Zip Files';

            trigger OnValidate()
            begin
                if "Create Multiple Zip Files" then
                    "Archive to Zip" := true;
            end;
        }
        field(30; "Parallel Processing"; Boolean)
        {
            Caption = 'Parallel Processing';
        }
        field(31; "Max No. Of Jobs"; Integer)
        {
            Caption = 'Max No. Of Jobs';
            MinValue = 1;
            InitValue = 3;
        }
        field(32; "Earliest Start Date/Time"; DateTime)
        {
            Caption = 'Earliest Start Date/Time';

            trigger OnLookup()
            var
                DateTimeDialog: Page "Date-Time Dialog";
            begin
                DateTimeDialog.SetDateTime(RoundDateTime("Earliest Start Date/Time", 1000));
                if DateTimeDialog.RunModal() = Action::OK then
                    "Earliest Start Date/Time" := DateTimeDialog.GetDateTime();
            end;
        }
        field(33; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Not Started","In Progress",Failed,Completed;
            OptionCaption = 'Not Started,In Progress,Failed,Completed';
            Editable = false;
        }
        field(35; "Execution Start Date/Time"; DateTime)
        {
            Caption = 'Execution Start Date/Time';
            Editable = false;
        }
        field(36; "Execution End Date/Time"; DateTime)
        {
            Caption = 'Execution End Date/Time';
            Editable = false;
        }
        field(37; "Latest Data Check Date/Time"; DateTime)
        {
            Caption = 'Latest Data Check Date/Time';
            Editable = false;
        }
        field(38; "Data check status"; Enum "Audit Data Check Status")
        {
            Caption = 'Data check status';
            Editable = false;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
        AuditFileExportTok: Label 'Audit File Export', Locked = true;

    trigger OnInsert()
    var
        AuditFileExportSetup: Record "Audit File Export Setup";
    begin
        AuditFileExportSetup.Get();
        Rec.Validate("Audit File Export Format", AuditFileExportSetup."Audit File Export Format");
        "Parallel Processing" := TaskScheduler.CanCreateTask();
        FeatureTelemetry.LogUsage('0000JN6', AuditFileExportTok, 'Audit File Export Document was created');
    end;

    trigger OnDelete()
    var
        AuditFileExportMgt: Codeunit "Audit File Export Mgt.";
    begin
        AuditFileExportMgt.DeleteExport(Rec);
    end;
}
