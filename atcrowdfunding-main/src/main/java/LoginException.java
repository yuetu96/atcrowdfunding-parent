/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/26 11:38
 */
public class LoginException extends RuntimeException {

    //需要2个构造器

    public LoginException() {
    }

    public LoginException(String message) {
        super(message);
    }
}
