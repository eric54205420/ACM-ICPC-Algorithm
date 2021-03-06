Const
  MaxPoint = 100+1;
  MaxEdge  = 1000+10;
  inf      = 'poj1325.txt';
  ouf      = 'poj1325ans.txt';
  Ondbg    = true;

Type
  TEdge = record
            target,nextpos:integer;
          end;

Var
  Edges:array[1..MaxEdge]  of TEdge;
  First:array[1..MaxPoint] of integer;
  EdgesNum:integer;

  Visited:array[1..MaxPoint] of boolean;
  LinkTo :array[1..MaxPoint] of integer;

  n,m,k,ans:integer;

Procedure AddEdge(src,trg:longint);
begin
  inc(EdgesNum);
  with Edges[EdgesNum] do
  begin
    target:=trg;
    nextpos:=First[src];
  end;
  First[src]:=EdgesNum;
end;

Procedure ReadData;
var
  i,index,src,trg:integer;
begin
  fillchar(First,sizeof(First),0);
  EdgesNum:=0;

  readln(m,k);
  for i:=1 to k do
  begin
    readln(index,src,trg);
    if src*trg<>0 then AddEdge(src,trg);
  end;
end;

Function  FindMatch(src:integer):boolean;
var
  now,new,ptrpos:integer;
begin
  now:=src;
  ptrpos:=First[now];
  FindMatch:=false;
  while ptrpos<>0 do
  begin
    new:=Edges[ptrpos].target;
    if not Visited[new] then
    begin
      Visited[new]:=true;
      if (LinkTo[new]=0) or (FindMatch(LinkTo[new])) then
      begin
        LinkTo[new]:=now;
        FindMatch:=true;
        exit;
      end;
    end;
    ptrpos:=Edges[ptrpos].nextpos;
  end;
end;

Procedure Hungary;
var
  i:integer;
begin
  ans:=0;
  Fillchar(LinkTo,SizeOf(LinkTo),0);

  for i:=1 to n do
  begin
    Fillchar(Visited,SizeOf(Visited),false);
    if FindMatch(i) then inc(ans);
  end;
end;

Begin
  if Ondbg then
  begin
    Assign(input,inf);
    Reset(input);
    Assign(output,ouf);
    Rewrite(output);
  end;

  read(n);
  while n>0 do
  begin
    ReadData;
    Hungary;
    writeln(ans);
    read(n);
  end;

  if Ondbg then
  begin
    Close(input);
    Close(output);
  end;
End.
