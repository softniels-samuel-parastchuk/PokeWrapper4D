unit ItemPocket.Entity;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  TItemPocketEntity = class
  type
    TCategories = class
    private
      Fname: string;
      Furl: string;
    public
      property name: string read Fname write Fname;
      property url: string read Furl write Furl;
    end;

    TNames = class
    type
      TLanguage = class
      private
        Fname: string;
        Furl: string;
      public
        property name: string read Fname write Fname;
        property url: string read Furl write Furl;
      end;
    private
      Flanguage: TLanguage;
      Fname: string;
    public
      constructor Create; overload;
      destructor Destroy; override;
      property language: TLanguage read Flanguage write Flanguage;
      property name: string read Fname write Fname;
    end;
  private
    Fcategories: TObjectList<TCategories>;
    Fid: integer;
    Fname: string;
    Fnames: TObjectList<TNames>;
    procedure SetFcategories(const Value: TObjectList<TCategories>);
    procedure SetFnames(const Value: TObjectList<TNames>);
  public
    constructor Create; overload;
    destructor Destroy; override;
    property categories: TObjectList<TCategories> read Fcategories
      write SetFcategories;
    property id: integer read Fid write Fid;
    property name: string read Fname write Fname;
    property names: TObjectList<TNames> read Fnames write SetFnames;
  end;

implementation

{ TItemPocketEntity }

constructor TItemPocketEntity.Create;
begin
  Fcategories := TObjectList<TCategories>.Create;
  Fnames := TObjectList<TNames>.Create;
end;

destructor TItemPocketEntity.Destroy;
begin
  Fcategories.Free;
  Fnames.Free;
  inherited;
end;

procedure TItemPocketEntity.SetFcategories(const Value
  : TObjectList<TCategories>);
begin
  FreeAndNil(Fcategories);
  Fcategories := Value;
end;

procedure TItemPocketEntity.SetFnames(const Value: TObjectList<TNames>);
begin
  FreeAndNil(Fnames);
  Fnames := Value;
end;

{ TItemPocketEntity.TNames }

constructor TItemPocketEntity.TNames.Create;
begin
  Flanguage := TLanguage.Create;
end;

destructor TItemPocketEntity.TNames.Destroy;
begin
  Flanguage.Free;
  inherited;
end;

end.
