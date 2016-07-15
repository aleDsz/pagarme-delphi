unit Transaction;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  PagarMeModel,
  IPagarMeModel,
  System.Rtti;

type
  TTransaction = class(TPagarMeModel)
  private
  public
    constructor new(response : TDictionary<string,TValue>);
    procedure capture(amount : integer);
    procedure refund(amount : integer = 0);
  published
  end;

implementation

{ TTransaction }

procedure TTransaction.capture(amount: integer);
begin

end;

constructor TTransaction.new(response: TDictionary<string, TValue>);
begin
  inherited;
end;

procedure TTransaction.refund(amount: integer = 0);
begin
  if amount = 0 then
    amount := Self.getParameter('amount').AsInteger;
end;

end.
