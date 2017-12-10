; Script para iniciar aplicaciones con una sola tecla y para navegar dentro
; de ellas (más o menos).
; Si no explico bien en el video qué estoy haciendo, creo que mis
; comentarios son una buena ayuda para guiarse, igual recuerden que yo no soy programadord.
; Después de esta introducción omitiré las tildes porque "jaja salu2".
; Tendrán que modificar el script para que se ajuste a sus necesidades.
; Para saber cómo se llama cada ventana usa el "Window Spy" de AHK.


#NoEnv                                      ;; Recomendado para rendimiento y futuras versiones de AutoHotkey.
; #Warn                                     ;; Advierte sobre errores comunes.
SendMode Input                              ;; Recomendado para nuevos scripts debido a su velocidad
                                            ;; superior y fiabilidad.
SetWorkingDir %A_ScriptDir%                 ;; Asegura un directorio
Menu, Tray, Icon, shell32.dll, 92           ;; Cambia el icono a un planeta, ayuda a diferenciarlo.
#SingleInstance force                       ;; Corre una sola instancia del script a la vez para que no te preocupes.


F1::   ;;------------------------------------------;; activa el codigo al presionar F1, es para FireFox
 IfWinNotExist, ahk_class MozillaWindowClass       ;; verifica si no existe la ventana de FF
 Run, firefox.exe     		                   ;; si no existe la ejecuta.
 GroupAdd, MPfirefox, ahk_class MozillaWindowClass ;; esto lo explico a partir de la linea 55.
 if WinActivate ("ahk_exe firefox.exe")
   GroupActivate, MPfirefox, r
 else
    WinActivate ahk_class MozillaWindowClass 
 Return


F3:: ; premiere
  IfWinNotExist, ahk_class Premiere Pro ;;revisa si existe la ventana del programas
	 Run, Adobe Premiere Pro.exe    ;; si no existe, lo ejecuta
  WinActivate ahk_class Premiere Pro    ;; Si es que existe, lo vuelve la ventana activa.
  Return

F4:: ; photoshop
  IfWinNotExist, ahk_class Photoshop
    Run, Photoshop.exe
  WinActivate ahk_class Photoshop
  Return

#IfWinActive ahk_class Photoshop
  F4::
  IfWinNotExist, ahk_class Qt5QWindowIcon
  Run, C:\Program Files\PureRef\PureRef.exe         ;; activa PureRef, un programa para colocar referencias.
    GroupAdd, MPphotoshop, ahk_class Qt5QWindowIcon ;; creamos un grupo en el que
    GroupAdd, MPphotoshop, ahk_class Photoshop      ;; incluimos PS y PureRef.
  if WinActivate ("ahk_exe Photoshop.exe")          ;; Determina si PS esta abierto
    GroupActivate, MPphotoshop, r                   ;; Lee el grupo de PS y PureRef
  else WinActivate ahk_class Qt5QWindowIcon         ;; y cambia entre ambos programas
Return

#If ;; detiene el uso de comandos dependendiendo de la vetana activa

F2::                              ;; Explorador de Windows. Adelante la explicacion
IfWinNotExist ahk_class CabinetWClass
  Run, explorer.exe               ;;Hasta aqui todo normal, lo siguiente varia.
  GroupAdd, MPexplorers, ahk_class CabinetWClass
                                  ;; Asignamos las ventanas a un grupo porque no tenemos el "lujo" de pestañas
                                  ;; cada aplicacion debera tener un grupo distinto.
if WinActivate ("ahk_exe explorer.exe")
    GroupActivate, MPexplorers, r ;; Estamos activando el grupo que definimos
                                  ;; anteriormente y con "r" estamos leyendo la clase "CabinetWClass" que son
                                  ;; las ventanas del explorer. ¿Tiene sentido, no? xdxd
else
  WinActivate ahk_class CabinetWClass
Return                            

+F3:: ; activador de chrome
  IfWinNotExist, ahk_exe chrome.exe
    Run, chrome.exe
    WinActivate ahk_exe chrome.exe
  Return

+F1:: ;activador de word
Process, Exist, WINWORD.EXE
	If errorLevel = 0
		Run, WINWORD.EXE
	else
	{
	GroupAdd, MPwords, ahk_class OpusApp
	if WinActive("ahk_class OpusApp")
		GroupActivate, MPwords, r
	else
		WinActivate ahk_class OpusApp
}
Return

+F2:: ;atom
IfWinNotExist, ahk_exe atom.exe
  Run, atom.exe
  WinActivate ahk_exe atom.exe
Return

+F4:: ; activador de excel
Process, Exist, EXCEL.EXE
	If errorLevel = 0
		Run, EXCEL.EXE
	else
	{
	GroupAdd, MPexcels, ahk_class XLMAIN
	if WinActive("ahk_class XLMAIN")
		GroupActivate, MPexcels, r
	else
		WinActivate ahk_class XLMAIN
}
Return

+F5:: ; activar/cambiar audition
IfWinNotExist, ahk_class audition10
  Run, Adobe Audition CC.exe
  WinActivate ahk_class audition10
Return

;;------------------------------------------------------------------------------------
;; V.1.0 Todo el codigo que sigue debe ser escrito despues de los comando principales
;; porque #IfWinActive sobreescribe todo lo que tiene a continuacion hasta que
;; otro #IfWinActive aparezca.
;; ----------------------------------------------------------------------------------
;; V.1.1 Para romper con el #IfWinActive ahk_class Class, basta colocar un #IfWinActive.
;; No he encontrado otra forma de terminarlo, la linea anterior a esta tampoco ha sido probada.
;; --------------------------------------------------------------------------------------
;; V.1.2 Ya se probó y efectivamente "#IfWinActive" solitario elimina cualquier
;; condicional que impide que las combinaciones de teclas funcionen fuera del "#IfWinActive Ejemplo".
;; Adicionalmente #If tambien es util para esto, revisar https://autohotkey.com/docs/commands/_If.htm


#IfWinActive ahk_class CabinetWClass ; todo lo siguiente funciona solamente en explorer
  !+WheelUp::                        ; es para navegar con la rueda del raton en el explorador.
    Send {enter}                     ; Aun estoy viendo si realmente vale la pena. 
  Return                             ; Puedes eliminar desde la linea 127 en adelante e igual funcionara 
  +WheelUp::                         
    Send {right}                     
  Return
  +WheelDown::
    Send {left}
  Return
  WheelUp::
    Send {up}
  Return
  WheelDown::
    Send {down}
  Return
  !+WheelDown::
    Send !{left}
  Return
#IfWinActive ahk_class MozillaWindowClass
  !+WheelUp::
      Send ^{PgDn}
  Return
  !+WheelDown::
      Send ^{PgUp}
  Return
#IfWinActive ahk_exe chrome.exe
  !+WheelUp::
      Send ^{PgDn}
  Return
  !+WheelDown::
      Send ^{PgUp}
  Return

#If
