unit PagarMeModel;

interface

uses
  PagarMeRequest,
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  PagarMeObject,
  System.Rtti;

type
  TPagarMeModel = class(TPagarMeObject)
  private
    Request : TPagarMeRequest;
  public
    constructor new(response : TDictionary<string,TValue>);
    procedure save();
    procedure create();
    procedure delete();
    procedure refresh();
    function  find(params : TDictionary<string,TValue>) : TList<TPagarMeModel>;
    function  findById(id : TValue) : TPagarMeModel;
    function  findAll(page : integer = 1; count : integer = 10) : TList<TPagarMeModel>;
    function  getUrl() : string;
  published
  end;

implementation

{ TPagarMeModel }

constructor TPagarMeModel.new(response: TDictionary<string, TValue>);
begin
  inherited;
  Request := TPagarMeRequest.new();
end;

procedure TPagarMeModel.create;
begin

end;

procedure TPagarMeModel.delete;
begin

end;

function TPagarMeModel.find(params: TDictionary<string, TValue>) : TList<TPagarMeModel>;
begin

end;

function TPagarMeModel.findAll(page : integer = 1; count : integer = 10) : TList<TPagarMeModel>;
begin                     

end;

function TPagarMeModel.findById(id: TValue) : TPagarMeModel;
begin
  if id.IsEmpty then
    raise Exception.Create('Invalid Id.');
    
  Result := Request.get<TPagarMeModel>(Self.getUrl + '/' + id.AsString).First();
end;

function TPagarMeModel.getUrl: string;
begin
  result := Concat(ApiEndpoint, ClassName.ToLower.Substring(1), 's');
end;

procedure TPagarMeModel.refresh;
begin

  
end;

procedure TPagarMeModel.save;
begin

end;

end.
