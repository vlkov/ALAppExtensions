// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

using Microsoft.Utilities;

table 5266 "Audit File Export Line"
{
    DataClassification = CustomerContent;
    Caption = 'Audit File Export Line';

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            TableRelation = "Audit File Export Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Task ID"; Guid)
        {
            Caption = 'Task ID';
        }
        field(4; Progress; Integer)
        {
            Caption = 'Progress';
            ExtendedDatatype = Ratio;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Not Started","In Progress",Failed,Completed;
            OptionCaption = 'Not Started,In Progress,Failed,Completed';
        }
        field(6; "Data Class"; Enum "Audit File Export Data Class")
        {
            Caption = 'Data Class';
        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(8; "No. Of Attempts"; Integer)
        {
            Caption = 'No. Of Retries';
            InitValue = 3;
        }
        field(10; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(11; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(20; "Audit File Name"; Text[1024])
        {
            Caption = 'Audit File Name';
        }
        field(21; "Audit File Content"; Blob)
        {
            Caption = 'Audit File Content';
        }

        field(30; "Server Instance ID"; Integer)
        {
            Caption = 'Server Instance ID';
        }
        field(31; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        field(32; "Created Date/Time"; DateTime)
        {
            Caption = 'Created Date/Time';
        }
    }

    keys
    {
        key(PK; ID, "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        ActivityLog: Record "Activity Log";
    begin
        ActivityLog.SetRange("Record ID", RecordId());
        ActivityLog.DeleteAll();
    end;
}
