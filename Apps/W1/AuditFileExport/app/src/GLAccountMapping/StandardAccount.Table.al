// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

table 5263 "Standard Account"
{
    DataClassification = CustomerContent;
    Caption = 'Standard Account';

    fields
    {
        field(1; Type; Enum "Standard Account Type")
        {
            Caption = 'Account Type';
        }
        field(2; "Category No."; Code[20])
        {
            Caption = 'Category No.';
            TableRelation = "Standard Account Category"."No." where("Standard Account Type" = field(Type));
        }
        field(3; "No."; Code[20])
        {
            NotBlank = true;
            Caption = 'No.';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Extended No."; Text[500])
        {
            Caption = 'Extended No.';
        }
    }

    keys
    {
        key(PK; Type, "Category No.", "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description)
        {

        }
    }
}
