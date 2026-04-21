// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

page 5265 "Standard Account Categories"
{
    PageType = List;
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    SourceTable = "Standard Account Category";
    Caption = 'Standard Account Categories';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(StandardAccountType; Rec."Standard Account Type")
                {
                    ToolTip = 'Specifies the type of standard general ledger accounts.';
                }
                field(Name; Rec."No.")
                {
                    ToolTip = 'Specifies the category of standard general ledger accounts that is used for mapping.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the standard account category that is used for mapping.';
                }
                field(ExtendedNo; Rec."Extended No.")
                {
                    ToolTip = 'Specifies the extended category code when the original category code exceeds 20 characters.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StandardAccountCodes)
            {
                Caption = 'Standard Accounts';
                ToolTip = 'Show the standard account codes that are linked to the selected category.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ImportCodes;
                RunObject = page "Standard Accounts";
                RunPageLink = Type = field("Standard Account Type"), "Category No." = field("No.");
            }
        }
    }
}
