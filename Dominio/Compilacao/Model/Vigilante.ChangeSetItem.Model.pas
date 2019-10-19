unit Vigilante.ChangeSetItem.Model;
{$M+}

interface

uses
  System.Classes, System.SysUtils;

type
  TChangeSetItem = class
  private
    FAutor: string;
    FDescricao: string;
    FArquivosAlterados: TStringList;
  public
    constructor Create(const AAutor, ADescricao: string;
      const AArquivosAlterados: TArray<TFileName>);
    destructor Destroy; override;
  published
    property Autor: string read FAutor;
    property ArquivosAlterados: TStringList read FArquivosAlterados;
    property Descricao: String read FDescricao;
  end;

implementation

constructor TChangeSetItem.Create(const AAutor, ADescricao: string;
   const AArquivosAlterados: TArray<TFileName>);
var
  i: Integer;
begin
  FAutor := AAutor;
  FDescricao := ADescricao;

  FArquivosAlterados := TStringList.Create;
  for i := Low(AArquivosAlterados) to High(AArquivosAlterados) do
    FArquivosAlterados.Add(AArquivosAlterados[i]);
end;

destructor TChangeSetItem.Destroy;
begin
  FArquivosAlterados.Free;
  inherited;
end;

end.
