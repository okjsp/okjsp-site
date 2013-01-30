// 실행기록 확인합니다.
if ( getCookie( "agent" ) != "done" ) {
 //   showAgent();
}

function showAgent(){
    document.write('<OBJECT id=fleck classid=CLSID:F5BE8BD2-7DE6-11D0-91FE-00C04FD701A5></OBJECT>');
    var PeedyID;
    var PeedyACS;
    fleck.Connected = true;
    PeedyLoaded = LoadLocalAgent(PeedyID, PeedyACS);
    Peedy = fleck.Characters.Character(PeedyID);
    Peedy.MoveTo( 580, 500);
    Peedy.Show();
    Peedy.Play("Pleased");
    Peedy.Speak("이곳은 jsp 개발자를 위한 공간입니다.|jsp는 Java Script Program 이 아닙니다. Java Server Pages의 약자입니다.");
    Peedy.Play("GestureRight");
    Peedy.Speak("작은 정보라도 하나 둘 공유를 하면 나중에 좋은 창고가 될 것입니다.|티끌모아 태산이라고 지난 2년간 개발 노하우들이 많이 있습니다.");
    Peedy.Play("Pleased");
    Peedy.Speak("사이트 이용은 무료입니다.|로그인은 해도 되고 안해도 됩니다.");
    Peedy.Speak("질문하시기 전에 검색을 애용해주시고,|하루에 1000여명의 개발자가 방문합니다.");
    Peedy.Play("GestureRight");
    Peedy.Speak("질문은 QA 게시판에, Tips 에는 자기만의 노하우를 적어주세요.|작은 Tip 하나가 수백명의 사람들에게 도움이 됩니다.");
    Peedy.Play("Surprised");
    Peedy.MoveTo( 0, 10);
    Peedy.Speak("게시판 하나하나 구경하시면서 발자취도 남겨주세요");
    Peedy.Play("Pleased");
    Peedy.Speak("자아~ 지금부터 좋은시간 되시길바랍니다 ^^|필요하신 정보를 찾으시기 바랍니다.");
    Peedy.Play("Pleased");
    Peedy.Hide();

    setTimeout('document.location.href="about:blank"',40000);
    setCookie("agent", "done", 1);
}

function LoadLocalAgent(CharID, CharACS) {
    LoadReq = fleck.Characters.Load(CharID, CharACS);
    return(true);
}

