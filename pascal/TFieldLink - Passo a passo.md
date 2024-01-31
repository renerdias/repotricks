
Unidad 12. Componentes de bases de datos: TDBTrackBar
Nesta unidade aprendemos a criar componentes vinculados a bancos de dados. Os componentes de base de dados (componentes data-aware) são simplesmente componentes padrão, como os que fomos criando ao longo do curso, aos quais se acrescenta a funcionalidade de poder vincular a uma base de dados. Este link pode ser somente leitura (o componente pode refletir o estado do campo do banco de dados, mas não atualizá-lo) ou somente edição (se esta atualização for possível). O componente que desenvolveremos será um componente de edição descendente do TTrackBar, o componente que o Delphi incorpora na aba Win95.

 Escolhi esta escolha porque ilustra o caso mais comum: de um componente existente descende um novo vinculado a um banco de dados (como acontece, por exemplo, com o controle TDBEdit, descendente de TEdit). Antes de começar, vale a pena diferenciar entre dois tipos de componentes vinculados a dados: • Aqueles que estão vinculados a um único campo do banco de dados, como os controles TDBEdit, TDBLabel, etc. e o componente que desenvolveremos nesta unidade • Aqueles que vinculam vários campos do banco de dados, como o controle TDBGrid. Então vamos trabalhar estudando como é feita a conexão entre o componente e o banco de dados. A ligação entre o componente e o banco de dados: TDataLink e TFieldDataLink Quando um componente vinculado a um banco de dados é desenvolvido, a conexão entre eles não é feita diretamente, mas sim através de um objeto TDataLink. Este objeto DataLink fornece uma série de propriedades, métodos e eventos que facilitam a comunicação entre o banco de dados e o controle associado:


Todos los componentes de bases de datos utilizan un objeto TDataLink para comunicarse con la base de datos. Pero generalmente el componente no se conecta ciertamente a este objeto, sino que lo hace a uno de sus descendientes: TFieldDataLink o TGridDataLink. 
¿Cuándo utilizar uno u otro? Nada más fácil: si el componente que queremos crear debe conectarse a un solo campo de la base de datos utilizaremos un TFieldDataLink (por ejemplo los componentes DBEdit, DBLabel,... ). Si, por el contrario, nuestro componente debe conectarse a varios campos de la base de datos utilizaremos el objeto TGridDataLink (o en algún caso, el objeto TDataLink directamente). 
Cómo ya hemos mencionado, nuestro componente se conectará a un sólo campo de la base de datos por lo que conviene que estudiemos las propiedades y métodos del objeto TFieldDataLink: 
Métodos: 
Edit: al llamar a este método, el registro actual del data source se pone en estado de edición (siempre y cuando sea posible). Si tiene éxito, se devuelve True, en caso contrario se devuelve False. 
Modified: cuando el componente de base de datos cambia los valores del control debe informar al objeto data source de que dicho campo se ha producido. Para ello se llama a este método. Cabe destacar que la llamada a este método es sólo una notificación al objeto de que se han producido cambios, pero nada más. Será el propio DataLink el que, cuando los necesite, nos pedirá el nuevo valor a almacenar en la base de datos mediante el evento OnUpdateData. 
Reset: este método permite descargar los cambios y recuperar los datos del registro desde el Data Source. 
Propiedades 
CanModify: propiedad de sólo lectura que indica si el control puede modificar el valor del campo. Si el campo o dataset es de sólo lectura, entonces, modified devuelve falso. 
Control: esta propiedad devuelve una referencia al control data. Cuando el control crea el objeto data link, debe asignar a esta propiedad el valor self. 
Editing: propiedad de sólo lectura que devuelve true si el data source está en estado de edición. 
Field: esta propiedad de sólo lectura devuelve una referencia al campo de la base de datos o nil si el data link no está enlazado a un campo. 
FieldName: esta propiedad almacena el nombre del campo de la base de datos enlazado. 
Eventos 
OnActiveChange: como su propio nombre indica este evento es activado cuando la propiedad active del data source cambia. 
OnDataChange: este evento es llamado cada que el registro cambia. En este evento el programador debe recuperar los nuevos valores del campo desde el data source. 
OnEditingChange: este evento es activado cuando el data source se pone en estado de edición, así como cuando deja de estarlo. 
OnUpdateData: este evento es llamado cuando el data source necesita actualizar los datos desde el control. En este evento debemos codificar los pasos necesarios para actualizar el registro de la base de datos. Sólo se llamará a este evento si el campo ha sido modificado (el método modified ha sido llamado). Obviamente, si estamos construyendo un componente de sólo lectura no necesitaremos codificar nada en este método. 
Una vez conocido el arsenal que tenemos a nuestra disposición, es hora de utilizarlo: ¡es la guerra! ;-) 
Añadiendo la propiedad ReadOnly 
Si nos fijamos en los controles enlazados a datos incluidos con Delphi, comprobaremos que todos tienen una propiedad que indica si el control puede modificar los datos del data source asociado o no. Esta es la propiedad ReadOnly. Este es uno de los pasos genéricos que hay que realizar siempre que construyamos un componente de base de datos. 
Hasta aquí está claro. Lo que no está tan claro es cómo hacerlo. Me explico. Imáginemos que queremos construir un nuevo componente enlazado a una base de datos, ( que curioso, justo lo que queremos ;-)). Podemos encontrarnos en uno de los siguientes casos (partimos siempre de un componente no enlazado a una base de datos): 
    • Tenemos el código fuente del componente original: perfecto, este es el caso más sencillo. Basta con crear una propiedad ReadOnly y, en el momento de ir actualizar el contenido de la base de datos, comprobar previamente dicha propiedad. 
    • Partimos de un componente del que no tenemos el código fuente: esto ya es más complicado. Dependiendo de cómo se haya escrito el componente original (existencia de métodos protected, etc), nuestra tarea puede ir de lo medianamente sencillo a lo totalmente imposible. :-( 
Nuestro caso, aunque no lo parezca, es el segundo. Es cierto que con Delphi se entrega el código fuente de los componentes, pero esto no quiere decir que lo podamos distribuir libremente. Se puede distribuir libremente el código fuente de los componentes que nosotros desarrollemos, pero no del componente antecesor del nuestro si este forma parte de los controles estandar de Delphi. Así que vamos a suponer que no disponemos del código fuente del componente TTrackBar, lo cuál hará la tarea aún más interesante. 
Antes de proseguir un pequeño inciso: ojo si partimos de un componente que ya tenga la propiedad ReadOnly. Esto no indica nada. De hecho, tendríamos que asegurarnos de sincronizar la propiedad ReadOnly del control con el estado real del data source. Un ejemplo de este caso es el control TEdit, que ya tiene la propiedad ReadOnly, la cual no tiene nada que ver con el estado del data source asociado; de hecho, el componente TEdit no está asociado a ninguna base de datos. 
Una vez hecha está aclaración, veamos en nuestro caso cómo podemos implementar la propiedad ReadOnly en nuestro componente. La declaración es sencilla: 
TTrackBar = class(TrackBar)
private
  FReadOnly : boolean;
... 
published
  property ReadOnly : boolean read FReadOnly write FReadOnly default False;
...
end;
Ahora bien, un control en estado de sólo lectura, no acepta las pulsaciones de teclas ni los clics del ratón. ¿Cómo conseguir este efecto en nuestro componente? Tenemos dos posibilidades: 
    • Reimplementar (override) los métodos de mensajes KeyDown, MouseDown, etc. del componente ancestor. En cada uno de estos métodos deberíamos comprobar si el componente está en estado de sólo lectura. En caso afirmativo, obviamos la pulsación, mientras que en caso negativo, llamamos al método heredado (con inherited MouseDown por ejemplo). 
Esta es una aproximación que suele funcionar en la mayoría de los casos, pero que en nuestro caso concreto no lo hace. El problema radica en que, aunque el valor de la propiedad ReadOnly sea True, el componente sigue admitiendo las entradas procedentes del teclado y el ratón. Esto es debido a que el código fuente del componente TTrackBar, tal y cómo se puede comprobar en el código fuente de la VCL, se límita básicamente a encapsular un control estándar de Windows 95. Por ello, el control ya ha procesado la tecla pulsada antes de ejecutar el código introducido en el evento KeyDown, por lo que no le afecta nada de lo codificado en él. De modo que deshechemos en este caso concreto esta posibilidad, pero teniendo en cuenta que si estuvieramos descendiendo de un ancestor propio, este sería el procedimiento adecuado a seguir.
    • La segunda posibilidad consiste en implementar (override) el procedimiento de mensajes del control por medio del del método WndProc. 
La explicación detallada de los procedimientos de mensajes de windows queda fuera del alcance de este capítulo, ya que forma parte del propio núcleo de Windows, de modo que me limitare a exponer el funcionamiento básico del mismo. Explicaciones detalladas pueden encontrarse en la ayuda en línea de Delphi y en la ayuda del API de Windows. En cualquier caso, si quereis que dediquemos una unidad del curso a este tema, no teneis más que escribirme.
La explicación del método WndProc, cómo acabo de mencionar, de forma un tanto simplista, es la siguiente: 
Toda ventana en Windows tiene mecanismos estándar para gestionar los mensajes denominados manejadores de mensajes. En Delphi, la VCL define un sistema de distribución de mensajes que traduce en llamadas a métodos todos los mensajes Windows dirigidos a un objeto en particular. El diagrama siguiente muestra el sistema de distribución de mensajes: 

Cuando queramos procesar de una forma particular un mensaje en concreto, bastará con con redefinir el método manejador del mensaje utilizando la directiva message (veremos un ejemplo de esto un poco más adelante). Pero si esto no nos basta, y lo que queremos es que el mensaje no se llegue a distribuir a su manejador, debemos capturar el mensaje en el método WndProc, ya que este método filtra los mensajes antes de pasarlos a Dispatch, que a su vez los pasa finalmente al manejador de cada mensaje particular. 
Esto es lo que realizamos en nuestro componente: 
TDBTrackBar = class(TTrackBar)
...
protected
  procedure WndProc(var Message: TMessage); override;
...

implementation
...

procedure TDBTrackBar.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
  begin
    {Si el control está en read only o no está en estado de edición,
     obviamos las pulsaciones de teclas y los mensajes del ratón}
    if FReadOnly OR (not FReadOnly AND (FDatalink<>nil) AND not
       FDataLink.Edit) then
    begin
       if ((Message.Msg >= WM_MOUSEFIRST) AND (Message.Msg <=WM_MOUSELAST))
       OR (Message.Msg = WM_KEYDOWN) OR (Message.Msg = WM_KEYUP) then
         exit;
       end;
    end;
  inherited WndProc(Message);
end;
Primeramente comprobamos si estamos en tiempo de diseño. Si la respuesta es afirmativa, nos limitamos a llamar al procedimiento WndProc heredado. Esta llamada es fundamental, ya que si no la hacemos el componente nunca recibiría los mensajes que le envía el sistema operativo y el resultado, por lo general, será un cuelgue del programa o incluso del ordenador. 
Si estamos en tiempo de ejecución, debemos capturar los mensajes de teclado y ratón y evitar que pasen al componente siempre que el componente esté en estado de sólo lectura. Para ello comprobamos el rango del mensaje pasado: si este es uno de los que queremos eliminar simplemente salimos del procedimiento sin llamar a WndProc. En caso contrario, somos buenos y dejamos que el resto de mensajes lleguen al componente :-) 
Con esto ya tenemos solucionado el tema de la propiedad ReadOnly. Aunque lo hemos solucionado con poco código, no os engañeis: el tema de la captura de mensajes es uno de los temas más complejos (y potentes) que hemos visto a lo largo del curso. Os recomiendo que antes de empezar a utilizar capturas de este tipo os leais muy detenidamente toda la ayuda disponible en Delphi y en el API sobre este tema. Os evitareis muchos disgustos ;-) 
Implementando el DataLink 
Ha llegado el momento de añadir a nuestro componente el enlace con la base de datos. Para ello tenemos que construir un objeto TDataLink, concretamente un TFieldDataLink, para conectar el componente a la base de datos. Veamos la declaración completa de nuestro componente: 
  TDBTrackBar = class(TTrackBar)
  private
    FReadOnly : boolean;
    FDataLink : TFieldDataLink;
    function GetDataField : string;
    procedure SetDataField(const Value : string);
    function GetDataSource : TDataSource;
    procedure SetDataSource(Value : TDataSource);
    procedure UpdateData(Sender: TObject);
    procedure DataChange(Sender : TObject);
    procedure EditingChange(Sender : TObject);
  protected
    procedure CMExit(var Message: TWMNoParams); message CM_EXIT;
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property ReadOnly : boolean read FReadOnly write FReadOnly default False;
    property DataField : string read GetDataField write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
  end;
Primero declaramos el campo FDataLink de tipo TFieldDataLink. Ahora debemos crearlo en el constructor de nuestro componente y enganchar los eventos del mismo que nos interesan: 
constructor TDBTrackBar.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle - [csReplicatable]; // El control no se permite en un DBCtrlGrid
  FReadOnly:=False;
  FDataLink:=TFieldDataLink.Create;
  FDataLink.OnDataChange:=DataChange;
  FDataLink.OnUpdateData:=UpdateData;
  // FDataLink.OnEditingChange:=EditingChange; Descomentar esta línea para que el control tenga AutoEdit
  FDataLink.Control:=Self;
end;
Una vez creado el DataLink, enganchamos a los eventos OnDataChange y OnUpdateData nuestros manejadores para los mismos. Además, asignamos el valor de la propiedad Control del DataLink una referencia a nuestro componente. 
Por último, dos cosas: primero: nuestro componente no tiene capacidades de replicación por lo que quitamos dicho flag de la propiedad ControlStyle (de este modo no se podrá utilizar el control en un TDBCtrlGrid). Segundo: Hay controles de base de datos que tiene capacidad de AutoEdición (p.e. el control TEdit). En principio no queremos que nuestro componente tenga esta caracterísca, pero si os interesa probarlo, basta con que descomenteis la línea que asigna el evento OnEditingChange. 
Además de construir el DataLink, al final hay que destruirlo, o sea que: 
destructor TDBTrackBar.Destroy;
begin
  FDataLink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;
Una vez creado, el usuario querrá poderlo utilizar ;-) de modo que vamos a proporcionarle las propiedades que todo control enlazado a datos tiene: DataSource y DataField. Comencemos con la propiedad DataSource: 
property DataSource : TDataSource read GetDataSource write SetDataSource;

function TDBTrackBar.GetDataSource : TDataSource;
begin
  Result:=FDataLink.DataSource;
end;

procedure TDBTrackBar.SetDataSource(Value : TDataSource);
begin
  if FDataLink.DataSource<>Value then
  begin
    FDataLink.DataSource:=Value;
    if Value<>nil then
      Value.FreeNotification(Self);
  end;
end;
El método get de la propiedad no tiene ningún misterio: se limita a devolver el correspondiente DataSource de nuestro objeto DataLink. 
El método set si es algo más interesante. Cuando se asigna un nuevo valor a la propiedad, comprobamos que dicho valor sea distinto de nil y, en caso afirmativo, llamamos al método FreeNotification del nuevo data source asignado. Venga, una pausa para que consulteis en la ayuda en línea que hace este método. Espero... 
¿Os ha quedado claro? ¿qué no demasiado? Pues para eso estoy yo, para intentar hacerlo un poco mejor que la ayuda en línea. Supongamos que no añadimos la línea Value.FreeNotification(self) e imaginemos que ya hemos terminado el componente y un usuario va a utilizarlo. Para ello, se crea en un módulo de datos su tabla paradox (objeto TTable) y un TDataSource. Luego, en un form de su aplicación coloca nuestro TDBTrackBar y asigna a la propiedad DataSource el Data Source que tiene en el módulo de datos. Lo más normal de mundo ¿no?. Ahora resulta que el usuario cambia de opinión, va al módulo de datos y borra el TDataSource. En este momento, nuestro componente tiene en la propiedad data source una referencia inválida (el objeto del módulo de datos ha sido destruido). Esto provocará un error severo cuando seleccionemos nuestro componente y puede provocar el cuelgue del propio Delphi. Chungo ¿verdad? Pues todo esto se evita añadiendo la famosa línea. De este modo le estamos diciendo al objeto DataSource del módulo de datos: notifícame cuando te vas a destruir para que yo limpie la referencia que apunta a tí. Y esta limpieza se realiza cuando recibimos la notificación: 
procedure TDBTrackBar.Notification(AComponent : TComponent; Operation : Toperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation=opRemove) AND (FDataLink<>nil) AND (AComponent=DataSource) then
    DataSource:=nil;
end;
Veamos ahora la propiedad DataField: 
property DataField : string read GetDataField write SetDataField;

function TDBTrackBar.GetDataField : string;
begin
  Result:=FDataLink.FieldName;
end;

procedure TDBTrackBar.SetDataField(const Value : string);
begin
  FDataLink.FieldName:=Value;
end;
Está chupada, así que vamos a algo más interesante. 
Lectura de los valores de los campos de la base de datos 
Una vez que tenemos el objeto DataLink creado, ya podemos utilizarlo para recuperar el valor del campo de la base de datos. El mecanismo es muy sencillo: cada vez que el data source indica un cambio en sus datos (bien sea por un desplazamiento a otro registro de la tabla, modificación del registro actual, etc) el objeto DataLink disparará el evento OnDataChange. En respuesta a este evento nuestro componente debe leer el nuevo valor del campo y reflejarlo de forma visual en el componente. 
Recordemos que en el constructor hemos enlazado el método UpdateData como respuesta al evento OnUpdateData. Veamos ahora cómo codificamos este método: 
procedure TDBTrackBar.DataChange(Sender : TObject);
begin
  if FDataLink.Field=nil then
    Position:=0
  else
    Position:=FDataLink.Field.AsInteger;
end;
Primero comprobamos que haya un campo asignado en la propiedad Field del DataLink y, en caso negativo, se devuelve un valor arbitrario como posición del TrackBar (en este caso se devuelve 0). En caso afirmativo, basta con leer el valor del campo de la base de datos mediante FDataLink.Field.AsInteger y asignarlo a la propiedad position del TrackBar. 
Así de simple. Pero conviene tener en cuenta dos aspectos: 
1. Por conveniencia, leemos el valor del campo como entero, ya que es lo que nos interesa a nuestros propósitos, ya que nuestro componente se enlazará a campos numéricos de la base de datos. Si el usuario intenta enlazarlo con un campo no numérico, obtendrá la excepción 'xxx is not a valid numeric value', cosa perfectamente normal. 
2. Una vez leído el valor del campo, hay que actualizar el componente para que refleje el nuevo valor. Esta tarea variará mucho en función del componente , pero básicamente consistirá en asignar el valor del campo a una determinada propiedad y llamar al método Paint para que se muestre el nuevo valor. En nuestro caso, basta con asignar el valor del campo a la propiedad position del TrackBar, ya que dicha propiedad heredada se encargará de repintar el componente. 
Una vez que hemos aprendido a asignar el nuevo valor del campo al componente, nos queda aprender cómo hacer el paso contrario, es decir, cuando el usuario modifica el valor de la propiedad position del trackBar (mediante el teclado, el ratón, o por código), dicho valor debe actualizarse en el campo de la base de datos. En la siguiente sección veremos cómo hacerlo. 
Actualizando el valor del campo de la base de datos 
El primer paso que debemos ejecutar para actualizar el valor del campo de la base de datos, es informar al objeto DataLink de que se ha producido un cambio. Para ello debemos llamar al método Modified del DataLink. La cuestión de cuando llamarlo, dependerá del tipo de componente que estemos construyendo. En nuestro caso es bastante simple: cada vez que se produce un cambio en la propiedad position, se genera un mensaje CNHScroll (o CCNVScroll si el salto es de más de una unidad). Los mensajes que contienen el prefijo CN son mensajes internos de la VCL de Delphi (Component Notification) y estos son dos claros ejemplos de mensajes que debemos reimplementar, ya que sólo se generan estos mensajes cuando se ha producido un cambio en el estado del TrackBar, lo que los hace ideales para nuestros propósitos: 
 TDBTrackBar = class(TTrackBar)
  ....
  protected
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
  ...

implementation

procedure TDBTrackBar.CNHScroll(var Message: TWMHScroll);
begin
  inherited;
  FDataLink.Modified
end;

procedure TDBTrackBar.CNVScroll(var Message: TWMVScroll);
begin
  inherited;
  FDataLink.Modified
end;
El mecanismo de implementar nuestro propio manejador de mensajes es simple: en la sección de interface definimos los métodos que deben responder a los mensajes junto con la directiva message seguida del nombre del mensaje a capturar. 
En la sección de implementación, nos limitamos a informar al DataLink de que se han producido cambios en el valor del campo (aunque donde realmente se han producido es en el propio componente y el llamar a Modified es una "declaración de intenciones") y que el objeto DataLink debe tenerlo en cuenta cuando vaya a actualizar el registro de la base de datos. 
Con esto, el objeto DataLink sabe que se han producido cambios, por lo que cuando sea necesario actualizar el registro (por una llamada a Post, movimiento del puntero del data set, etc), se activará el evento OnUpdateData. Sólo tenemos que codificar en respuesta a este evento (recordemos que ya lo enganchamos al método UpdateData del constructor), las instrucciones necesarias para actualizar el valor del campo de la base de datos, lo cuál lo conseguimos asignando el nuevo valor a la propiedad DataLink.Field: 
procedure TDBTrackBar.UpdateData(Sender: TObject);
begin
 FDataLink.Field.AsInteger := Position;
end;
Con esto ya casi está. Nos queda un último paso. Una vez que el usuario del componente hace click con el ratón para modificar el valor de la propiedad position, informamos al DataLink de que el campo va a cambiar llamando al método Modified. De este modo el objeto DataLink activará el evento OnUpdateData para asignar el nuevo valor al campo, y este evento se disparará cuando sea requerido por el data source. Pero tambien debemos disparar este evento cuando nuestro componente pierda el foco: así nos aseguramos de que el campo se actualizará correctamente. 
Para realizar esta tarea debemos reimplementar el mensaje CMExit, que se genera cuando un componente pierde el foco: 
procedure CMExit(var Message: TWMNoParams); message CM_EXIT;
...
procedure TDBTrackBar.CMExit(var Message: TWMNoParams);
begin
  try
    FDataLink.UpdateRecord; { Actualizamos el data link}
  except
    SetFocus; { Si falla la actualización, mantenemos el foco en el control}
    raise; { y relanzamos la excepción}
  end;
  inherited;
end;
En este método nos limitamos a llamar al método UpdateRecord para forzar la actualización del campo de la base de datos. Si se produce una excepción en este proceso (tipicamente por asignar un valor no válido al campo, por clave duplicada, etc). mantenemos el foco en el control y relanzamos la excepción para que la vea el usuario. 
Un detalle a destacar: el método UpdateRecord no lo hemos visto al estudiar los métodos del objeto TFieldDataLink ya que está definido en TDataLink, el antecesor de TFieldDataLink. Su cometido es obvio: forzar la llamada a OnUpdateData para que se asigne un nuevo valor al campo de la base de datos (recordar que previamente se ha debido también llamar al método Modified, ya que en caso contrario el evento OnUpdateData no se dispararía). 
Con esto hemos terminado nuestro componente. Tan sólo nos queda registrarlo y disfrutar de él. 
Por último estoy recibiendo diversas sugerencias sobre temas para próximas unidades, por lo cuál me gustaría que me enviaseis ideas a mi dirección de correo electrónico. Entre los temas que me han sugerido hasta el momento destacan: 
    • Ayuda en línea para los componentes 
    • Desarrollo de controles ActiveX 
    • Componentes con conexión a múltiples campos de la base de datos 
Código fuente del componente 
unit DBTrackBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Comctrls, Controls, DB, DBTables, DBCtrls;

type
  TDBTrackBar = class(TTrackBar)
  private
    FReadOnly : boolean;
    FDataLink : TFieldDataLink;
    function GetDataField : string;
    procedure SetDataField(const Value : string);
    function GetDataSource : TDataSource;
    procedure SetDataSource(Value : TDataSource);
    procedure UpdateData(Sender: TObject);
    procedure DataChange(Sender : TObject);
    procedure EditingChange(Sender : TObject);
  protected
    procedure CMExit(var Message: TWMNoParams); message CM_EXIT;
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property ReadOnly : boolean read FReadOnly write FReadOnly default False;
    property DataField : string read GetDataField write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
  end;

procedure Register;

implementation

constructor TDBTrackBar.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle - [csReplicatable];  // El control no se permite en un DBCtrlGrid
  FReadOnly:=False;
  FDataLink:=TFieldDataLink.Create;
  FDataLink.OnDataChange:=DataChange;
  FDataLink.OnUpdateData:=UpdateData;
  // FDataLink.OnEditingChange:=EditingChange;  Descomentar esta línea para que el control tenga AutoEdit
  FDataLink.Control:=Self;
end;

destructor TDBTrackBar.Destroy;
begin
  FDataLink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

function TDBTrackBar.GetDataField : string;
begin
  Result:=FDataLink.FieldName;
end;

procedure TDBTrackBar.SetDataField(const Value : string);
begin
  FDataLink.FieldName:=Value;
end;

function TDBTrackBar.GetDataSource : TDataSource;
begin
  Result:=FDataLink.DataSource;
end;

procedure TDBTrackBar.SetDataSource(Value : TDataSource);
begin
  if FDataLink.DataSource<>Value then
  begin
    FDataLink.DataSource:=Value;
    if Value<>nil then
      Value.FreeNotification(Self);
  end;
end;

procedure TDBTrackBar.Notification(AComponent : TComponent; Operation : Toperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation=opRemove) AND (FDataLink<>nil) AND (AComponent=DataSource) then
    DataSource:=nil;
end;

procedure TDBTrackBar.DataChange(Sender : TObject);
begin
  if FDataLink.Field=nil then
    Position:=0
  else
    Position:=FDataLink.Field.AsInteger;
end;

procedure TDBTrackBar.CNHScroll(var Message: TWMHScroll);
begin
  inherited;
  FDataLink.Modified
end;

procedure TDBTrackBar.CNVScroll(var Message: TWMVScroll);
begin
  inherited;
  FDataLink.Modified
end;

procedure TDBTrackBar.UpdateData(Sender: TObject);
begin
 FDataLink.Field.AsInteger := Position;
end;

procedure TDBTrackBar.EditingChange(Sender: TObject);
begin
  FReadOnly := not FDataLink.Editing;
end;

procedure TDBTrackBar.CMExit(var Message: TWMNoParams);
begin
 try
   FDataLink.UpdateRecord; { Actualizamos el data link}
 except
   SetFocus;   { Si falla la actualización, mantenemos el foco en el control}
   raise;      { y relanzamos la excepción}
 end;
 inherited;
end;

procedure TDBTrackBar.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
  begin
    {Si el control está en read only o no está en estado de edición,
     obviamos las pulsaciones de teclas y los mensajes del ratón}
    if FReadOnly OR (not FReadOnly AND (FDatalink<>nil) AND not FDataLink.Edit) then
    begin
    if ((Message.Msg >= WM_MOUSEFIRST) AND (Message.Msg <= WM_MOUSELAST))
    OR (Message.Msg = WM_KEYDOWN) OR (Message.Msg = WM_KEYUP) then
      exit;
    end;
  end;
  inherited WndProc(Message);
end;

procedure Register;
begin
  RegisterComponents('Curso', [TDBTrackBar]);
end;

end.

