unit Vigilante.Compilacao.Observer.Impl;

interface

uses
  System.Generics.Collections, Vigilante.Compilacao.Observer,
  Vigilante.Compilacao.Model;

type
  TCompilacaoSubject = class(TInterfacedObject, ICompilacaoSubject)
  private
    FList: TList<ICompilacaoObserver>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Adicionar(const ACompilacaoObserver: ICompilacaoObserver);
    procedure Notificar(const ACompilacao: ICompilacaoModel);
    procedure Remover(const ACompilacaoObserver: ICompilacaoObserver);
  end;

implementation

uses
  System.SysUtils, System.Threading, System.Classes;

constructor TCompilacaoSubject.Create;
begin
  FList := TList<ICompilacaoObserver>.Create;
end;

destructor TCompilacaoSubject.Destroy;
begin
  FreeAndNil(FList);
end;

procedure TCompilacaoSubject.Adicionar(const ACompilacaoObserver
  : ICompilacaoObserver);
begin
  if FList.Contains(ACompilacaoObserver) then
    Exit;
  FList.Add(ACompilacaoObserver);
end;

procedure TCompilacaoSubject.Notificar(const ACompilacao: ICompilacaoModel);
begin
  TParallel.&For(0, Pred(FList.Count),
    procedure(i: integer)
    begin
      TThread.Queue(TThread.CurrentThread,
        procedure
        begin
          FList.Items[i].NovaAtualizacao(ACompilacao);
        end);
    end);
end;

procedure TCompilacaoSubject.Remover(const ACompilacaoObserver
  : ICompilacaoObserver);
begin
  if FList.Contains(ACompilacaoObserver) then
    FList.Remove(ACompilacaoObserver)
end;

end.
