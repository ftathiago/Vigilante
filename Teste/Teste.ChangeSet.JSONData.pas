unit Teste.ChangeSet.JSONData;

interface

uses
  System.JSON;

type
  TChangeSetJSONData = class
    class function Pegar: TJSONArray;
    class function PegarChangeSetItem: TJSONObject;
    class function PegarChangeSetItemDoisArquivos: TJSONObject;
  end;

implementation

class function TChangeSetJSONData.Pegar: TJSONArray;
begin
  Result := TJSONObject.ParseJSONValue(
    '[ '+
    '  { '+
    '    "_class": "com.ibm.team.build.internal.hjplugin.RTCChangeLogChangeSetEntry", '+
    '    "commitId": null, '+
    '    "affectedPaths": [ '+
    '      "/src/Classes/nomeDoArquivo.pas" '+
    '    ], '+
    '    "author": { '+
    '      "absoluteUrl": "http://jenkins/user/jian.kowalski", '+
    '      "fullName": "Jose da Silva Sauro" '+
    '    }, '+
    '    "msg": "Descrição do commit", '+
    '    "timestamp": 1548268243953 '+
    '  }, '+
    '  { '+
    '    "_class": "com.ibm.team.build.internal.hjplugin.RTCChangeLogChangeSetEntry", '+
    '    "commitId": null, '+
    '    "affectedPaths": [ '+
    '      "/src/Classes/nomeDoArquivo.pas" '+
    '    ], '+
    '    "author": { '+
    '      "absoluteUrl": "http://jenkins/user/jian.kowalski", '+
    '      "fullName": "Jose da Silva Sauro" '+
    '    }, '+
    '    "msg": "Descrição do commit", '+
    '    "timestamp": 1548436904300 ' +
    '  } ' +
    '] ') as TJSONArray;
end;

class function TChangeSetJSONData.PegarChangeSetItem: TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(
    '{ ' +
    '  "_class": "com.ibm.team.build.internal.hjplugin.RTCChangeLogChangeSetEntry", ' +
    '  "commitId": null, ' +
    '  "affectedPaths": [ ' +
    '    "/src/Classes/nomeDoArquivo.pas" ' +
    '  ], ' +
    '  "author": { ' +
    '    "absoluteUrl": "http://jenkins/user/jian.kowalski", ' +
    '    "fullName": "Jose da Silva Sauro" ' +
    '  }, ' +
    '  "msg": "Descrição do commit", ' +
    '  "timestamp": 1548268243953 ' +
    '} ') as TJSONObject;
end;

class function TChangeSetJSONData.PegarChangeSetItemDoisArquivos: TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(
    '{ ' +
    '  "_class": "com.ibm.team.build.internal.hjplugin.RTCChangeLogChangeSetEntry", ' +
    '  "commitId": null, ' +
    '  "affectedPaths": [ ' +
    '    "/src/Classes/nomeDoArquivo.pas", ' +
    '    "/src/Classes/nomeDoArquivo2.pas" ' +
    '  ], ' +
    '  "author": { ' +
    '    "absoluteUrl": "http://jenkins/user/jian.kowalski", ' +
    '    "fullName": "Jose da Silva Sauro" ' +
    '  }, ' +
    '  "msg": "Descrição do commit", ' +
    '  "timestamp": 1548268243953 ' +
    '} ') as TJSONObject;
end;

end.
