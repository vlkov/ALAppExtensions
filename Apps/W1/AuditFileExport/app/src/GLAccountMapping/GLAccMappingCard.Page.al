#pragma warning disable AA0247
page 5272 "G/L Acc. Mapping Card"
{
    PageType = ListPlus;
    SourceTable = "G/L Account Mapping Header";
    Caption = 'G/L Account Mapping';
    PromotedActionCategories = 'New, Process';
    DataCaptionExpression = '';
    ApplicationArea = Basic, Suite;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(Mapping)
            {
                Caption = 'Mapping';
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the mapping code that represents the reporting period.';
                }
                field(StandardAccountType; Rec."Standard Account Type")
                {
                    ToolTip = 'Specifies the type of the standard general ledger accounts.';
                }
                field(AuditFileExportFormat; Rec."Audit File Export Format")
                {
                    ToolTip = 'Specifies the audit file export format to which the standard general ledger accounts are linked.';
                }
                field(PeriodType; Rec."Period Type")
                {
                    ToolTip = 'Specifies the type for an accounting period or custom period with a flexible start date/time.';
                }
                field(AccountingPeriod; Rec."Accounting Period")
                {
                    ToolTip = 'Specifies the starting date of the accounting period that will be used as reporting period.';
                }
                field(StartingDate; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the starting date of the reporting period.';
                }
                field(EndingDate; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the ending date of the reporting period.';
                }
                field(StandardAccountCategoryNo; Rec."Standard Account Category No.")
                {
                    ToolTip = 'Specifies the category of the standard account or grouping code that is used for mapping.';
                }
                field(StanadrdAccountNo; Rec."Standard Account No.")
                {
                    ToolTip = 'Specifies the code of the standard account or grouping code that is used for mapping.';
                }
                field(IncludeIncomingBalance; Rec."Include Incoming Balance")
                {
                    ToolTip = 'Specifies if the incoming balance of G/L account of type "Balance Account" needs to be considered for mapping instead of the reporting period''s net change.';
                }
            }
            part(GLAccountMappingSubpage; "G/L Account Mapping Subpage")
            {
                SubPageLink = "G/L Account Mapping Code" = field(Code);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(InitMappingSource)
            {
                Caption = 'Initialize Source for Mapping';
                ToolTip = 'Generate lines on the G/L Account Mapping page based on an existing chart of accounts.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = GetSourceDoc;

                trigger OnAction()
                var
                    AuditMappingHelper: Codeunit "Audit Mapping Helper";
                begin
                    AuditMappingHelper.Run(Rec);
                    CurrPage.Update();
                end;
            }
            action(CopyMapping)
            {
                Caption = 'Copy from Another Mapping';
                ToolTip = 'Copy the G/L account mapping from another mapping code.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Copy;

                trigger OnAction()
                var
                    CopyGLAccountMapping: Report "Copy G/L Account Mapping";
                begin
                    Clear(CopyGLAccountMapping);
                    CopyGLAccountMapping.InitializeRequest(Rec.Code);
                    CopyGLAccountMapping.Run();
                    CurrPage.Update();
                end;
            }
        }
    }
}
