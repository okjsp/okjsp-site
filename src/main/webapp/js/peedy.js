// ������ Ȯ���մϴ�.
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
    Peedy.Speak("�̰��� jsp �����ڸ� ���� �����Դϴ�.|jsp�� Java Script Program �� �ƴմϴ�. Java Server Pages�� �����Դϴ�.");
    Peedy.Play("GestureRight");
    Peedy.Speak("���� ������ �ϳ� �� ������ �ϸ� ���߿� ���� â�� �� ���Դϴ�.|Ƽ����� �»��̶�� ���� 2�Ⱓ ���� ���Ͽ���� ���� �ֽ��ϴ�.");
    Peedy.Play("Pleased");
    Peedy.Speak("����Ʈ �̿��� �����Դϴ�.|�α����� �ص� �ǰ� ���ص� �˴ϴ�.");
    Peedy.Speak("�����Ͻñ� ���� �˻��� �ֿ����ֽð�,|�Ϸ翡 1000������ �����ڰ� �湮�մϴ�.");
    Peedy.Play("GestureRight");
    Peedy.Speak("������ QA �Խ��ǿ�, Tips ���� �ڱ⸸�� ���Ͽ츦 �����ּ���.|���� Tip �ϳ��� ������� ����鿡�� ������ �˴ϴ�.");
    Peedy.Play("Surprised");
    Peedy.MoveTo( 0, 10);
    Peedy.Speak("�Խ��� �ϳ��ϳ� �����Ͻø鼭 �����뵵 �����ּ���");
    Peedy.Play("Pleased");
    Peedy.Speak("�ھ�~ ���ݺ��� �����ð� �ǽñ�ٶ��ϴ� ^^|�ʿ��Ͻ� ������ ã���ñ� �ٶ��ϴ�.");
    Peedy.Play("Pleased");
    Peedy.Hide();

    setTimeout('document.location.href="about:blank"',40000);
    setCookie("agent", "done", 1);
}

function LoadLocalAgent(CharID, CharACS) {
    LoadReq = fleck.Characters.Load(CharID, CharACS);
    return(true);
}

