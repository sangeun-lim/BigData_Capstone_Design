package com.hallym.dao;

import com.hallym.vo.attachVO;
import com.hallym.vo.boardVO;
import com.hallym.vo.bookmarkVO;
import com.hallym.vo.ciVO;
import com.hallym.vo.ingredientsVO;
import com.hallym.vo.refrigeratorVO;
import com.hallym.vo.replyVO;
import com.hallym.vo.userVO;
import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class daoImpl implements dao {
  @Inject
  private SqlSession sqlSession;
  
  private static final String Namespace = "com.hallym.mybatis.sql.bartender";
  
  public int selectUser(String user_id) throws Exception {
    int result = ((Integer)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectUser", user_id)).intValue();
    return result;
  }
  
  public int signUp(userVO user) throws Exception {
    int result = this.sqlSession.insert("com.hallym.mybatis.sql.bartender.signUp", user);
    return result;
  }
  
  public userVO selectUserInfo(userVO user) throws Exception {
    userVO u = (userVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectUserInfo", user);
    return u;
  }
  
  public List<ciVO> selectRandomCocktailInfo(int ig) throws Exception {
	ciVO i = new ciVO();
	i.setIg1(ig);
    List<ciVO> c = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.selectRandomCocktailInfo", i);
    return c;
  }
  
  public List<ingredientsVO> loadSpiritIg(int spirit){
	  ingredientsVO i = new ingredientsVO();
	  i.setSpirits_type(spirit);
	  List<ingredientsVO> result = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.loadSpiritIg", i);
	  return result;
  }
  
  public ciVO selectCocktail(String cocktail_name) throws Exception {
    ciVO c = (ciVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectCocktail", cocktail_name);
    return c;
  }
  
  public List<ciVO> searchCocktail(String cocktail_name) throws Exception {
    List<ciVO> c = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.searchCocktail", cocktail_name);
    return c;
  }
  
  public List<ciVO> lac() throws Exception {
	    List<ciVO> c = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.lac");
	    return c;
  }
  
  public boolean modifyInfo(String user_id, String user_pw, String email) throws Exception {
    boolean result;
    userVO u = new userVO();
    u.setUser_pw(user_pw);
    u.setUser_id(user_id);
    u.setEmail(email);
    int c = this.sqlSession.update("com.hallym.mybatis.sql.bartender.modifyInfo", u);
    if (c == 1) {
      result = true;
    } else {
      result = false;
    } 
    return result;
  }
  
  public List<ingredientsVO> ingredientsList() throws Exception {
    List<ingredientsVO> list = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.selectIngredients");
    return list;
  }
  
  public int maxNo() throws Exception {
    if (this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxNo") == null)
      return 0; 
    return ((Integer)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxNo")).intValue();
  }
  
  public int addRefrige(int user_no, int ig) throws Exception {
    refrigeratorVO r = new refrigeratorVO();
    r.setUser_no(user_no);
    r.setIg1(ig);
    int result = this.sqlSession.insert("com.hallym.mybatis.sql.bartender.addRefridge", r);
    return result;
  }
  
  public int updateRefrige(int user_no, int ig, int sequence) throws Exception {
    refrigeratorVO r = new refrigeratorVO();
    r.setUser_no(user_no);
    r.setIg1(ig);
    r.setSequence(sequence);
    int result = 0;
    try {
      refrigeratorVO r1 = (refrigeratorVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.requiredIg", r);
      if (r1 != null)
        return 0; 
      result = this.sqlSession.update("com.hallym.mybatis.sql.bartender.updateRefrige", r);
    } catch (Exception exception) {}
    return result;
  }
  
  public refrigeratorVO selectRefrige(int user_no) throws Exception {
    refrigeratorVO r = new refrigeratorVO();
    r.setUser_no(user_no);
    r = (refrigeratorVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectRefrige", Integer.valueOf(user_no));
    return r;
  }
  
  public int deleteRefrige(refrigeratorVO r) {
    int result = this.sqlSession.update("com.hallym.mybatis.sql.bartender.deleteRefri", r);
    return result;
  }
  
  public List<ingredientsVO> searchIg(String ig_name) throws Exception {
    List<ingredientsVO> list = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.searchIg", ig_name);
    return list;
  }
  
  public List<ciVO> fitCocktail(int ig) throws Exception {
    List<ciVO> l = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.fitCocktail", Integer.valueOf(ig));
    return l;
  }
  
  public ciVO selectIg(int cocktail_no) throws Exception {
    ciVO c = (ciVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectIg", Integer.valueOf(cocktail_no));
    return c;
  }
  
  public int requiredIg(refrigeratorVO r) throws Exception {
    refrigeratorVO r1 = (refrigeratorVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.requiredIg", r);
    if (r1 != null) {
      if (r1.getUser_no() != 0) {
        return 1;
      } 
    } else {
      return 0;
    } 
    return 0;
  }
  
  public int addBoard(boardVO b) throws Exception {
    int i = this.sqlSession.insert("com.hallym.mybatis.sql.bartender.addBoard", b);
    return i;
  }
  
  public int addAttach(attachVO a) throws Exception {
    int i = this.sqlSession.insert("com.hallym.mybatis.sql.bartender.addAttach", a);
    return i;
  }
  
  public int maxNoBoard() throws Exception {
    if (this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxNoBoard") == null)
      return 0; 
    return ((Integer)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxNoBoard")).intValue();
  }
  
  public int maxNoAttach() throws Exception {
    if (this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxNoAttach") == null)
      return 0; 
    return ((Integer)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxNoAttach")).intValue();
  }
  
  public List<boardVO> loadBoardList(int page) throws Exception {
    boardVO b = new boardVO();
    b.setEnd(page * 10);
    b.setStart(page * 10 - 10);
    List<boardVO> result = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.loadBoardList", b);
    return result;
  }
  
  public List<boardVO> loadBoardList2(String word, int page) throws Exception {
	    boardVO b = new boardVO();
	    b.setWord(word);
	    b.setEnd(page * 10);
	    b.setStart(page * 10 - 10);
	    List<boardVO> result = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.loadBoardList2", b);
	    return result;
  }
  
  public List<boardVO> loadBoardList3(int page, String user_id) throws Exception {
	    boardVO b = new boardVO();
	    b.setEnd(page * 10);
	    b.setStart(page * 10 - 10);
	    b.setUser_id(user_id);
	    List<boardVO> result = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.loadBoardList3", b);
	    return result;
  }
  
  public int selectView(boardVO b) throws Exception {
    int result = ((Integer)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectView", b)).intValue();
    return result;
  }
  
  public boardVO loadBoard(boardVO b) throws Exception {
    boardVO result = (boardVO)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.loadBoard", b);
    return result;
  }
  
  public int updateView(boardVO b) throws Exception {
    int result = this.sqlSession.update("com.hallym.mybatis.sql.bartender.updateView", b);
    return result;
  }
  
  public List<attachVO> loadAttach(attachVO a) throws Exception {
    List<attachVO> result = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.loadAttach", a);
    return result;
  }
  
  public int deleteAttach(attachVO a) throws Exception {
    int result = this.sqlSession.delete("com.hallym.mybatis.sql.bartender.deleteAttach", a);
    return result;
  }
  
  public int deleteBoard(boardVO b) throws Exception {
    int result1 = this.sqlSession.delete("com.hallym.mybatis.sql.bartender.deleteBoard", b);
    int i = this.sqlSession.delete("com.hallym.mybatis.sql.bartender.deleteAttach2", b);
    return result1;
  }
  
  public int modifySave(boardVO b) throws Exception {
    int result1 = this.sqlSession.update("com.hallym.mybatis.sql.bartender.modifySave", b);
    return result1;
  }
  
  public List<replyVO> loadReply(replyVO r) throws Exception {
    List<replyVO> result = this.sqlSession.selectList("com.hallym.mybatis.sql.bartender.loadReply", r);
    return result;
  }
  
  public int saveReply(replyVO r) throws Exception {
    int result = this.sqlSession.insert("com.hallym.mybatis.sql.bartender.saveReply", r);
    return result;
  }
  
  public int maxReplyNo() throws Exception {
    if (this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxReplyNo") == null)
      return 0; 
    return ((Integer)this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.maxReplyNo")).intValue();
  }
  
  public int deleteReply1(replyVO r) throws Exception {
    int result = this.sqlSession.delete("com.hallym.mybatis.sql.bartender.deleteReply1", r);
    return result;
  }
  
  public int deleteReply2(replyVO r) throws Exception {
    int result = this.sqlSession.delete("com.hallym.mybatis.sql.bartender.deleteReply2", r);
    this.sqlSession.delete("com.hallym.mybatis.sql.bartender.deleteReply3", r);
    return result;
  }

	@Override
	public bookmarkVO selectBookmark(bookmarkVO b) {
		bookmarkVO result = this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.selectBookmark", b);
		return result;
	}

	@Override
	public int updateBookmark(bookmarkVO b) {
		int result = this.sqlSession.update("com.hallym.mybatis.sql.bartender.updateBookmark", b);
		return result;
	}
	
	@Override
	public int insertBookmark(bookmarkVO b) {
		int result = this.sqlSession.insert("com.hallym.mybatis.sql.bartender.insertBookmark", b);
		return result;
	}
	
	@Override
	public ciVO loadBC(int bookmark_no) {
		
		ciVO c = new ciVO();
		
		c.setCocktail_no(bookmark_no);
		
		ciVO result = this.sqlSession.selectOne("com.hallym.mybatis.sql.bartender.loadBC", c);
		return result;
	}
}
