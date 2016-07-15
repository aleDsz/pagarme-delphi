program PagarMeTests;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  System.Rtti,
  PagarMeService in '..\PagarMe\PagarMeService.pas',
  PagarMeObject in '..\PagarMe\PagarMeObject.pas',
  PagarMeModel in '..\PagarMe\PagarMeModel.pas',
  Transaction in '..\PagarMe\Transaction.pas',
  PagarMeRequest in '..\PagarMe\PagarMeRequest.pas',
  IPagarMeModel in '..\PagarMe\IPagarMeModel.pas';

var
  PagarMeService : TPagarMeService;
  PagarMeRequest : TPagarMeRequest;
  Transaction : TTransaction;
  Attributes : TDictionary<string,TValue>;

begin
  PagarMeService := TPagarMeService.getDefaultService();
  PagarMeService.ApiKey := 'ak_test_qtDOZfF5K0VDn17k04NxnQPIZ3r5wV';
  PagarMeService.EncryptionKey := 'ek_test_88XTnIhTUmWZ28X9Zh364A1KKOl6y0';
  Attributes := TDictionary<string,TValue>.Create;
  PagarMeRequest := TPagarMeRequest.new();

  Writeln('Testando Instância PagarMeService');
  Writeln(PagarMeService.ApiEndpoint);
  Writeln('');

  Writeln('Testando getUrl Transaction');
  Transaction := TTransaction.new(nil);
  Writeln(Transaction.getUrl);
  Writeln('');

  Writeln('Testando Obter Transaction');
  Transaction := Transaction.findById('573114') as TTransaction;
  Writeln('Id: ' + Transaction.getParameter('id').AsString);
  Writeln('');

  Readln;
end.
