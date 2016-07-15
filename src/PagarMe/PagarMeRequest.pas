unit PagarMeRequest;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  PagarMeService,
  PagarMeObject,
  RestClient,
  RestUtils,
  HttpConnection,
  RestJsonUtils,
  System.Rtti;

type
  TPagarMeRequest = class
  private
    PagarMeService : TPagarMeService;
    PagarMeObject : TPagarMeObject;
    RestClient : TRestClient;
    UserAgent : string;
  public
    constructor new();
    procedure post(url : string; params : TDictionary<string,TValue>);
    function  get<T>(url: string) : TList<T>;
    procedure put(url : string; params : TDictionary<string,TValue>);
    procedure delete(url : string; params : TDictionary<string,TValue>);
  published
  end;

implementation

{ TPagarMeRequest }

constructor TPagarMeRequest.new;
begin
  PagarMeService := TPagarMeService.getDefaultService();
  RestClient := TRestClient.Create(nil);
  RestClient.ConnectionType := HttpConnection.hctIndy;
end;

procedure TPagarMeRequest.delete(url: string;
  params: TDictionary<string, TValue>);
begin

end;

function TPagarMeRequest.get<T>(url: string) : TList<T>;
var
  JSON   : string;
  newObj : TList<T>;
begin
  PagarMeObject := TPagarMeObject.new(nil);
  url := url + '?api_key=' + PagarMeService.ApiKey;
  JSON := RestClient.Resource(url)
            .Accept(RestUtils.MediaType_Json)
            .ContentType(RestUtils.MediaType_Json)
            .Get();
  result := PagarMeObject.toObjects<T>(JSON);
end;

procedure TPagarMeRequest.post(url: string;
  params: TDictionary<string, TValue>);
begin

end;

procedure TPagarMeRequest.put(url: string;
  params: TDictionary<string, TValue>);
begin

end;

end.
