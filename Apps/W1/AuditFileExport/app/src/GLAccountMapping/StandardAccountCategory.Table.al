// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

table 5262 "Standard Account Category"
{
    DataClassification = CustomerContent;
    Caption = 'Standard Account Category';

    fields
    {
        field(1; "Standard Account Type"; Enum "Standard Account Type")
        {
            Caption = 'Standard Account Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Extended No."; Text[500])
        {
            Caption = 'Extended No.';
        }
    }

    keys
    {
        key(PK; "Standard Account Type", "No.")
        {
            Clustered = true;
        }
        key(ExtendedNoIndex; "Standard Account Type", "Extended No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description)
        {

        }
    }

    trigger OnDelete()
    var
        StandardAccount: Record "Standard Account";
    begin
        StandardAccount.SetRange(Type, "Standard Account Type");
        StandardAccount.SetRange("Category No.", "No.");
        StandardAccount.DeleteAll(true);
    end;
}
