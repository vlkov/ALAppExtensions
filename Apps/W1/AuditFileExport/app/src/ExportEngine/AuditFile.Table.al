// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

table 5267 "Audit File"
{
    DataClassification = CustomerContent;
    Caption = 'Audit File';

    fields
    {
        field(1; "Export ID"; Integer)
        {
            Caption = 'Export ID';
            Editable = false;
        }
        field(2; "File No."; Integer)
        {
            Caption = 'File No.';
            Editable = false;
        }
        field(4; "File Name"; Text[1024])
        {
            Caption = 'File Name';
            Editable = false;
        }
        field(5; "File Content"; Blob)
        {
            Caption = 'File Content';
        }
        field(6; "File Size"; Text[20])
        {
            Caption = 'File Size';
        }
    }

    keys
    {
        key(PK; "Export ID", "File No.")
        {
            Clustered = true;
        }
    }
}
