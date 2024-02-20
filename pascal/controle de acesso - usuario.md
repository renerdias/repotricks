Classe Singleton com Controle de Acesso de Usuários no Lazarus
Objetivo: Implementar uma classe singleton em Lazarus que gerencia o controle de acesso de usuários do sistema, buscando permissões no banco de dados.

Requisitos:

Lazarus
Banco de dados (ex: Firebird, MySQL)
Conhecimento básico de programação em Lazarus
Exemplo:

```Delphi
unit Unit1;

interface

uses
  Classes,
  DB,
  DBUtils,
  System.SysUtils;

type
  TUsuario = class(TObject)
  private
    FUsuarioID: Integer;
    FNome: String;
    FLogin: String;
    FPermissoes: TArray<String>;
    FDB: TFDConnection;
    FSQL: TSQLQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TUsuario;
    function GetUsuarioID: Integer;
    function SetUsuarioID(Value: Integer);
    function GetNome: String;
    function SetNome(Value: String);
    function GetLogin: String;
    function SetLogin(Value: String);
    function GetPermissoes: TArray<String>;
    function HasPermission(Permission: String): Boolean;
    procedure LoadPermissions;
  end;

var
  Usuario: TUsuario;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin
  inherited;
  FDB := TFDConnection.Create(nil);
  FSQL := TSQLQuery.Create(nil);
end;

destructor TUsuario.Destroy;
begin
  FDB.Free;
  FSQL.Free;
  inherited;
end;

class function TUsuario.Instance: TUsuario;
begin
  if Usuario = nil then
    Usuario := TUsuario.Create;
  Usuario.LoadPermissions;
  Result := Usuario;
end;

function TUsuario.GetUsuarioID: Integer;
begin
  Result := FUsuarioID;
end;

function TUsuario.SetUsuarioID(Value: Integer);
begin
  FUsuarioID := Value;
end;

function TUsuario.GetNome: String;
begin
  Result := FNome;
end;

function TUsuario.SetNome(Value: String);
begin
  FNome := Value;
end;

function TUsuario.GetLogin: String;
begin
  Result := FLogin;
end;

function TUsuario.SetLogin(Value: String);
begin
  FLogin := Value;
end;

function TUsuario.GetPermissoes: TArray<String>;
begin
  Result := FPermissoes;
end;

function TUsuario.HasPermission(Permission: String): Boolean;
begin
  Result := FPermissoes.IndexOf(Permission) > -1;
end;

procedure TUsuario.LoadPermissions;
var
  SQL: String;
begin
  FPermissoes.Clear;
  SQL := 'SELECT permissao FROM usuarios_permissoes WHERE usuario_id = :usuario_id';
  FSQL.SQL.Text := SQL;
  FSQL.Params.ParamByName('usuario_id').AsInteger := FUsuarioID;
  FSQL.Open;
  while not FSQL.IsEmpty do
  begin
    FPermissoes.Add(FSQL.FieldByName('permissao').AsString);
    FSQL.Next;
  end;
  FSQL.Close;
end;

end.
  ```
Use o código com cuidado.
Explicação:

A classe TUsuario é a classe singleton que encapsula a lógica de controle de acesso.
A função Instance garante que apenas uma instância da classe seja criada.
As propriedades GetUsuarioID, SetUsuarioID, GetNome, SetNome, GetLogin, SetLogin permitem manipular os dados do usuário.
A propriedade GetPermissoes retorna uma lista com as permissões do usuário.
A função HasPermission verifica se o usuário possui uma permissao específica.
O método LoadPermissions carrega as permissões do usuário do banco de dados.
Adaptação:

Adapte o código à sua estrutura de classes e banco de dados.
Modifique as consultas SQL de acordo com o seu esquema de banco de dados.
Adicione funcionalidades específicas do seu sistema.
Observações:

Este é um exemplo básico, personalize-o de acordo com suas necessidades.
Implemente mecanismos de segurança para proteger o acesso
