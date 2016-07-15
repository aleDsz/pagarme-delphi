unit PagarMeObject;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  REST.JsonReflect,
  REST.Json,
  PagarMeService,
  SuperObject,
  System.Rtti;

type
  TPagarMeObject = class(TPagarMeService)
  private
    sAttributes : TDictionary<string,TValue>;
    sUnsavedAttributes : TDictionary<string,TValue>;
  public
    procedure refresh(response : TDictionary<string,TValue>);
    function  toJson(params : TDictionary<string, TValue>) : TStringStream;
    function  toObject(CastType : TClass;Obj: TPagarMeObject): TObject;
    function  toObjects<T>(JSON : string) : TList<T>;
    function  getParameter(key : string) : TValue;
    procedure setParameter(key : string; value : TValue);
  published
    constructor new(response : TDictionary<string,TValue>);
    property Attributes : TDictionary<string,TValue> read sAttributes write sAttributes;
    property UnsavedAttributes : TDictionary<string,TValue> read sUnsavedAttributes write sUnsavedAttributes;
  end;

implementation

{ TPagarMeObject }

procedure TPagarMeObject.setParameter(key: string; value: TValue);
begin
  if Attributes.ContainsKey(key) then
    Attributes[key] := value.ToString();
end;

function TPagarMeObject.getParameter(key: string): TValue;
begin
  if Attributes.ContainsKey(key) then
    result := Attributes[key]
  else
    result := nil;
end;

constructor TPagarMeObject.new(response : TDictionary<string,TValue>);
begin
  Attributes := TDictionary<string,TValue>.Create;
  UnsavedAttributes := TDictionary<string,TValue>.Create;

  if response <> nil then
    if response.Count > 0 then
      refresh(response);
  inherited;
end;

procedure TPagarMeObject.refresh(response: TDictionary<string, TValue>);
var
  key: string;
begin
  for key in response.Keys do
  begin
    Attributes.AddOrSetValue(key, response[key]);
    UnsavedAttributes.Remove(key);
  end;
end;

function TPagarMeObject.toJson(params: TDictionary<string, TValue>): TStringStream;
var
  Json : TStringStream;
  key  : string;
  jsonString : TStringList;
begin
  params.TrimExcess;
  jsonString := TStringList.Create;

  jsonString.Add('{');
  for key in params.Keys do
  begin
    if not key.IsEmpty then
      jsonString.Add('"' + key + '":"' + params[key].AsString + '",');
  end;
  jsonString.Add('}');

  Json := TStringStream.Create(jsonString.Text.Substring(0, jsonString.Text.Length - 1));
  result := Json;
end;

function TPagarMeObject.toObject(CastType : TClass;Obj: TPagarMeObject): TObject;
var
  v : TValue;
begin
  Result := v.Cast(CastType.ClassInfo).AsObject;
end;

function TPagarMeObject.toObjects<T>(JSON: string): TList<T>;
var
  SuperObject      : ISuperObject;
  SuperArray       : TSuperArray;
  SuperTableString : TSuperTableString;
  ObjectList       : TList<T>;
  Obj              : T;
  Dictionary       : TDictionary<string,TValue>;
  i, k             : integer;
  Key              : string;
  Value            : TValue;
  Context          : TRttiContext;
begin
  Dictionary  := TDictionary<string,TValue>.Create();
  ObjectList  := TList<T>.Create();
  SuperObject := SO(JSON);
  if SuperObject.IsType(TSuperType.stArray) then
  begin
    for i := 0 to SuperArray.Length - 1 do
    begin
      SuperTableString := SuperArray.O[i].AsObject;
      for k := 0 to SuperTableString.GetNames.AsArray.Length - 1 do
      begin
        Key   := SuperArray.S[k];
        Value := SuperObject.S[Key];
        Dictionary.AddOrSetValue(Key, Value);
      end;
    end;
  end
  else if SuperObject.IsType(TSuperType.stObject) then
  begin
    SuperArray := SuperObject.AsObject.GetNames.AsArray;
    for i := 0 to SuperArray.Length - 1 do
    begin
      Key   := SuperArray.S[i];
      Value := SuperObject.S[Key];
      Dictionary.AddOrSetValue(Key, Value);
    end;
    Context := TRttiContext.Create();
    ObjectList.Add(Obj);
  end;

  Result := ObjectList;
end;

end.
