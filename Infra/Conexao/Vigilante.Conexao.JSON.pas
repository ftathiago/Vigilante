unit Vigilante.Conexao.JSON;

interface

uses
  System.JSON;

type
  IConexaoJSON = interface(IInterface)
    ['{60B461E7-F230-49FF-BC58-68C60D78954F}']
    function PegarCompilacao: TJSONObject;
    function PegarBuild: TJSONObject;
    function PegarPipeline: TJSONObject;
  end;

implementation

end.
