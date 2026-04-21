// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

table 5269 "Audit Export Data Type Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Audit Export Data Type Setup';
    LookupPageId = "Audit Export Data Type Setup";
    DrillDownPageId = "Audit Export Data Type Setup";

    fields
    {
        field(1; "Audit File Export Format"; Enum "Audit File Export Format")
        {
            Caption = 'Audit File Export Format';
        }
        field(2; "Export Data Type"; Enum "Audit File Export Data Type")
        {
            Caption = 'Export Data Type';
        }
        field(3; "Export Data Class"; Enum "Audit File Export Data Class")
        {
            Caption = 'Data Class';
        }
        field(4; "Export Enabled"; Boolean)
        {
            Caption = 'Export Enabled';
        }
    }

    keys
    {
        key(Key1; "Audit File Export Format", "Export Data Type")
        {
            Clustered = true;
        }
    }

    procedure InsertRecord(AuditFileExportFormat: Enum "Audit File Export Format"; ExportDataType: Enum "Audit File Export Data Type"; ExportDataClass: Enum "Audit File Export Data Class"; ExportEnabled: Boolean)
    begin
        if not Rec.Get(AuditFileExportFormat, ExportDataType) then begin
            Rec.Init();
            Rec."Audit File Export Format" := AuditFileExportFormat;
            Rec."Export Data Type" := ExportDataType;
            Rec.Insert();
        end;
        Rec."Export Data Class" := ExportDataClass;
        Rec."Export Enabled" := ExportEnabled;
        Rec.Modify();
    end;
}
