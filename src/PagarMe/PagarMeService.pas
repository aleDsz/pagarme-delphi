unit PagarMeService;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  System.Rtti;

type
  TPagarMeService = class(TObject)
  private
    sApiKey : String;
    sEncryptionKey : String;
    sApiEndpoint : String;
  public
    constructor new(response : TDictionary<string,TValue> = nil);
    class function getDefaultService : TPagarMeService;
    property ApiKey : string read sApiKey write sApiKey;
    property EncryptionKey : string read sEncryptionKey write sEncryptionKey;
    property ApiEndpoint : string read sApiEndpoint;
  published
  end;

implementation

var
  instance : TPagarMeService;

{ TPagarMeService }

constructor TPagarMeService.new(response : TDictionary<string,TValue> = nil);
begin
  sApiEndpoint := 'http://api.pagar.me/1/';
  EncryptionKey := '';
  ApiKey := '';
end;

class function TPagarMeService.getDefaultService: TPagarMeService;
begin
  if not assigned(instance) then
    instance := TPagarMeService.new();

  result := instance;
end;

end.
