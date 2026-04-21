// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AuditFileExport;

page 5262 "G/L Account Mapping Subpage"
{
    PageType = ListPart;
    SourceTable = "G/L Account Mapping Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Lines';
    ApplicationArea = Basic, Suite;

    layout
    {
        area(Content)
        {
            repeater(GLAccountMappingLines)
            {
                field(GLAccountNo; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the number of the account that is used to map the standard account or grouping code.';
                    StyleExpr = GLAccStyleExpr;
                    Editable = false;
                }
                field(GLAccountName; Rec."G/L Account Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the name of the account that is used to map the standard account or grouping code.';
                }
                field(CategoryNo; Rec."Standard Account Category No.")
                {
                    ToolTip = 'Specifies the category of the standard account or grouping code that is used for mapping.';
                }
                field(StandardAccountNo; Rec."Standard Account No.")
                {
                    ToolTip = 'Specifies the code of the standard account or grouping code that is used for mapping.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateGLEntriesExists)
            {
                Caption = 'Update G/L Entry Availability';
                ToolTip = 'Mark G/L accounts that have posted G/L entries in green. If option Include Incoming Balance enabled then all posted G/L entries are considered for calculation. Otherwise only G/L entries of the reporting period are considered.';
                Image = PostingEntries;
                trigger OnAction()
                var
                    GLAccountMappingHelper: Codeunit "Audit Mapping Helper";
                begin
                    GLAccountMappingHelper.UpdateGLEntriesExistStateForGLAccMapping(Rec."G/L Account Mapping Code");
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        GLAccountMappingHeader: Record "G/L Account Mapping Header";
    begin
        if GLAccountMappingHeader.FindFirst() then begin
            Rec.FilterGroup(4);
            Rec.SetRange("G/L Account Mapping Code", GLAccountMappingHeader.Code);
            Rec.FilterGroup(0);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateGLAccStyleExpr();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateGLAccStyleExpr();
    end;

    local procedure UpdateGLAccStyleExpr()
    begin
        if Rec."G/L Entries Exists" then
            GLAccStyleExpr := 'Favorable'
        else
            GLAccStyleExpr := '';
    end;

    var
        GLAccStyleExpr: Text;
}
