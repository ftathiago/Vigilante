unit Vigilante.Build.Observer.Impl;

interface

uses
  System.TypInfo, System.Generics.Collections, Vigilante.Build.Model,
  Vigilante.Build.Observer;

type
  TBuildSubject = class(TInterfacedObject, IBuildSubject)
  private
    FObservadores: TList<IBuildObserver>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Adicionar(const ABuildObserver: IBuildObserver);
    procedure Notificar(const ABuild: IBuildModel);
    procedure Remover(const ABuildObserver: IBuildObserver);
  end;

implementation

uses
  System.SysUtils, System.Threading, System.Classes;

constructor TBuildSubject.Create;
begin
  FObservadores := TList<IBuildObserver>.Create;
end;

destructor TBuildSubject.Destroy;
begin
  FreeAndNil(FObservadores);
  inherited;
end;

procedure TBuildSubject.Adicionar(const ABuildObserver: IBuildObserver);
begin
  if FObservadores.Contains(ABuildObserver) then
    Exit;
  FObservadores.Add(ABuildObserver);
end;

procedure TBuildSubject.Notificar(const ABuild: IBuildModel);
begin
  if FObservadores.Count = 0 then
    Exit;
  TParallel.For(0, Pred(FObservadores.Count),
    procedure(i: integer)
    begin
      TThread.Queue(TThread.CurrentThread,
        procedure
        begin
          FObservadores.Items[i].NovaAtualizacao(ABuild);
        end);
    end);
end;

procedure TBuildSubject.Remover(

  const ABuildObserver: IBuildObserver);
begin
  FObservadores.Remove(ABuildObserver);
end;

end.
