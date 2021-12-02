package com.hallym.service;

import com.hallym.dao.dao;
import com.hallym.vo.attachVO;
import com.hallym.vo.boardVO;
import com.hallym.vo.bookmarkVO;
import com.hallym.vo.ciVO;
import com.hallym.vo.ingredientsVO;
import com.hallym.vo.refrigeratorVO;
import com.hallym.vo.replyVO;
import com.hallym.vo.userVO;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import javax.inject.Inject;
import org.springframework.stereotype.Service;

@Service
public class serviceImpl implements service {
  @Inject
  dao dao;
  
  public int signUp(userVO user) throws Exception {
    int i = this.dao.selectUser(user.getUser_id());
    user.setUser_no(this.dao.maxNo() + 1);
    if (i == 1)
      return 0; 
    int d = this.dao.signUp(user);
    if (d > 0)
      return 1; 
    return 1;
  }
  
  public userVO signIn(userVO user) throws Exception {
    userVO u = this.dao.selectUserInfo(user);
    return u;
  }
  
  public List<ciVO> selectRandomCocktailInfo() throws Exception {
	  
	System.out.println("start");  
	Calendar cal = Calendar.getInstance();
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	List<ingredientsVO> ig = dao.loadSpiritIg(dayOfWeek);
	List<ciVO> result = new ArrayList<ciVO>();
	
	int k = (int)(Math.random()*100);
	
	for(int i = 0; i < ig.size(); i++) {
		List<ciVO> c = this.dao.selectRandomCocktailInfo(ig.get(i).getIg());
        
		for(int j = 0; j < c.size(); j++) {

			if(k >= c.size()-4) {
				k = k/10;
			}
			
	        if(j==k || j==k+1 || j==k+2 || j==k+3) {
	        	System.out.println(j);
	        	if(result.size() == 4) {
	        		break;
	        	}
	        	System.out.println("success");
	        	result.add(c.get(j));
	        }
		}
	}
    
    return result;
  }
  
  public ciVO selectCocktail(String cocktail_name) throws Exception {
    ciVO c = this.dao.selectCocktail(cocktail_name);
    return c;
  }
  
  public List<ciVO> searchCocktail(String cocktail_name) throws Exception {
    List<ciVO> c = this.dao.searchCocktail(cocktail_name);
    return c;
  }
  
  public boolean modifyInfo(String user_id, String user_pw, String email) throws Exception {
    boolean result = this.dao.modifyInfo(user_id, user_pw, email);
    return result;
  }
  
  public List<ingredientsVO> ingredientsList() throws Exception {
    List<ingredientsVO> list = this.dao.ingredientsList();
    return list;
  }
  
  public int addRefrige(int user_no, int ig) throws Exception {
    refrigeratorVO r = this.dao.selectRefrige(user_no);
    int sequence = 1;
    if (r == null) {
      this.dao.addRefrige(user_no, ig);
    } else if (r.getIg1() == 0) {
      sequence = 1;
    } else if (r.getIg2() == 0) {
      sequence = 2;
    } else if (r.getIg3() == 0) {
      sequence = 3;
    } else if (r.getIg4() == 0) {
      sequence = 4;
    } else if (r.getIg5() == 0) {
      sequence = 5;
    } else if (r.getIg6() == 0) {
      sequence = 6;
    } else if (r.getIg7() == 0) {
      sequence = 7;
    } else if (r.getIg8() == 0) {
      sequence = 8;
    } else if (r.getIg9() == 0) {
      sequence = 9;
    } else if (r.getIg10() == 0) {
      sequence = 10;
    } else if (r.getIg11() == 0) {
      sequence = 11;
    } else if (r.getIg12() == 0) {
      sequence = 12;
    } else if (r.getIg13() == 0) {
      sequence = 13;
    } else if (r.getIg14() == 0) {
      sequence = 14;
    } else if (r.getIg15() == 0) {
      sequence = 15;
    } else if (r.getIg16() == 0) {
      sequence = 16;
    } else if (r.getIg17() == 0) {
      sequence = 17;
    } else if (r.getIg18() == 0) {
      sequence = 18;
    } else if (r.getIg19() == 0) {
      sequence = 19;
    } else if (r.getIg20() == 0) {
      sequence = 20;
    } else if (r.getIg21() == 0) {
      sequence = 21;
    } else if (r.getIg22() == 0) {
      sequence = 22;
    } else if (r.getIg23() == 0) {
      sequence = 23;
    } else if (r.getIg24() == 0) {
      sequence = 24;
    } else if (r.getIg25() == 0) {
      sequence = 25;
    } else if (r.getIg26() == 0) {
      sequence = 26;
    } else if (r.getIg27() == 0) {
      sequence = 27;
    } else if (r.getIg28() == 0) {
      sequence = 28;
    } else if (r.getIg29() == 0) {
      sequence = 29;
    } else if (r.getIg30() == 0) {
      sequence = 30;
    } else {
      return 0;
    } 
    int result = this.dao.updateRefrige(user_no, ig, sequence);
    return result;
  }
  
  public refrigeratorVO loadRefrige(int user_no) throws Exception {
    refrigeratorVO r = new refrigeratorVO();
    r = this.dao.selectRefrige(user_no);
    if (r != null)
      return r; 
    return null;
  }
  
  public int deleteRefri(refrigeratorVO r) throws Exception {
    int i = this.dao.deleteRefrige(r);
    return i;
  }
  
  public List<ingredientsVO> searchIg(String ig_name) throws Exception {
    List<ingredientsVO> list = this.dao.searchIg(ig_name);
    return list;
  }
  
  public List<ciVO> fitCocktail(int user_no) throws Exception {
    ciVO ci = new ciVO();
    List<ciVO> result = new ArrayList<>();
    refrigeratorVO r = new refrigeratorVO();
    r = this.dao.selectRefrige(user_no);
    List<Integer> igs = new ArrayList<>();
    try {
      igs.add(Integer.valueOf(r.getIg1()));
      igs.add(Integer.valueOf(r.getIg2()));
      igs.add(Integer.valueOf(r.getIg3()));
      igs.add(Integer.valueOf(r.getIg4()));
      igs.add(Integer.valueOf(r.getIg5()));
      igs.add(Integer.valueOf(r.getIg6()));
      igs.add(Integer.valueOf(r.getIg7()));
      igs.add(Integer.valueOf(r.getIg8()));
      igs.add(Integer.valueOf(r.getIg9()));
      igs.add(Integer.valueOf(r.getIg10()));
      igs.add(Integer.valueOf(r.getIg11()));
      igs.add(Integer.valueOf(r.getIg12()));
      igs.add(Integer.valueOf(r.getIg13()));
      igs.add(Integer.valueOf(r.getIg14()));
      igs.add(Integer.valueOf(r.getIg15()));
      igs.add(Integer.valueOf(r.getIg16()));
      igs.add(Integer.valueOf(r.getIg17()));
      igs.add(Integer.valueOf(r.getIg18()));
      igs.add(Integer.valueOf(r.getIg19()));
      igs.add(Integer.valueOf(r.getIg20()));
      igs.add(Integer.valueOf(r.getIg21()));
      igs.add(Integer.valueOf(r.getIg22()));
      igs.add(Integer.valueOf(r.getIg23()));
      igs.add(Integer.valueOf(r.getIg24()));
      igs.add(Integer.valueOf(r.getIg25()));
      igs.add(Integer.valueOf(r.getIg26()));
      igs.add(Integer.valueOf(r.getIg27()));
      igs.add(Integer.valueOf(r.getIg28()));
      igs.add(Integer.valueOf(r.getIg29()));
      igs.add(Integer.valueOf(r.getIg30()));
    } catch (Exception exception) {}
    igs = (List<Integer>)igs.stream().distinct().collect(Collectors.toList());
    List<Integer> s = new ArrayList<>();
    for (int i = 1; i <= igs.size(); i++) {
      if (((Integer)igs.get(i - 1)).intValue() != 0) {
        List<ciVO> c = this.dao.fitCocktail(((Integer)igs.get(i - 1)).intValue());
        for (int j = 0; j < c.size(); j++)
          s.add(Integer.valueOf(((ciVO)c.get(j)).getCocktail_no())); 
      } 
    } 
    List<Integer> s1 = (List<Integer>)s.stream().distinct().collect(Collectors.toList());
    int igCount = 10;
    for (int l = 0; l < s1.size(); l++) {
      int freq = Collections.frequency(s, s1.get(l));
      ciVO ci2 = this.dao.selectIg(((Integer)s1.get(l)).intValue());
      if (ci2.getIg1() == 0) {
        igCount = 0;
      } else if (ci2.getIg2() == 0) {
        igCount = 1;
      } else if (ci2.getIg3() == 0) {
        igCount = 2;
      } else if (ci2.getIg4() == 0) {
        igCount = 3;
      } else if (ci2.getIg5() == 0) {
        igCount = 4;
      } else if (ci2.getIg6() == 0) {
        igCount = 5;
      } else if (ci2.getIg7() == 0) {
        igCount = 6;
      } else if (ci2.getIg8() == 0) {
        igCount = 7;
      } else if (ci2.getIg9() == 0) {
        igCount = 8;
      } else if (ci2.getIg10() == 0) {
        igCount = 9;
      } 
      if (freq == igCount)
        result.add(ci2); 
    } 
    return result;
  }
  
  public int requiredIg(refrigeratorVO r) throws Exception {
    int result = this.dao.requiredIg(r);
    return result;
  }
  
  public int addBoard(boardVO b) throws Exception {
    int no = this.dao.maxNoBoard();
    if (no == 0) {
      no = 1;
    } else {
      no++;
    } 
    b.setNo(no);
    int i = this.dao.addBoard(b);
    return i;
  }
  
  public int addAttach(attachVO a) throws Exception {
    int no = this.dao.maxNoAttach();
    if (no == 0) {
      no = 1;
    } else {
      no++;
    } 
    a.setAttach_no(no);
    int i = this.dao.addAttach(a);
    return i;
  }
  
  public List<boardVO> loadBoardList(int page) throws Exception {
    List<boardVO> result = this.dao.loadBoardList(page);
    
    return result;
  }
  
  public List<boardVO> loadBoardList(String word, int page) throws Exception {
	    List<boardVO> result = this.dao.loadBoardList2(word, page);
	    
	    return result;
  }
  
  public List<boardVO> loadBoardList(int page, String user_id) throws Exception {
	    List<boardVO> result = this.dao.loadBoardList3(page, user_id);
	    
	    return result;
}
  
  public boardVO loadBoard(int no) throws Exception {
    boardVO b1 = new boardVO();
    b1.setNo(no);
    int view = this.dao.selectView(b1);
    b1.setView(view + 1);
    this.dao.updateView(b1);
    boardVO b2 = this.dao.loadBoard(b1);
    return b2;
  }
  
  public List<attachVO> loadAttach(attachVO a) throws Exception {
    List<attachVO> result = this.dao.loadAttach(a);
    return result;
  }
  
  public int deleteAttach(attachVO a) throws Exception {
    int result = this.dao.deleteAttach(a);
    return result;
  }
  
  public int deleteBoard(boardVO b) throws Exception {
    int result = this.dao.deleteBoard(b);
    return result;
  }
  
  public int modifySave(boardVO b) throws Exception {
    int result = this.dao.modifySave(b);
    return result;
  }
  
  public List<replyVO> loadReply(replyVO r) throws Exception {
    List<replyVO> result = this.dao.loadReply(r);
    return result;
  }
  
  public int saveReply(replyVO r) throws Exception {
    if (this.dao.maxReplyNo() == 0) {
      r.setReply_no(1);
    } else {
      r.setReply_no(this.dao.maxReplyNo() + 1);
    } 
    int result = this.dao.saveReply(r);
    return result;
  }
  
  public int deleteReply(replyVO r) throws Exception {
    int result;
    if (r.getReply_no() == 0) {
      result = this.dao.deleteReply1(r);
    } else {
      result = this.dao.deleteReply2(r);
    } 
    return result;
  }

	@Override
	public bookmarkVO selectBookmark(int user_no) throws Exception {
		bookmarkVO b = new bookmarkVO();
		b.setUser_no(user_no);
		if(dao.selectBookmark(b)!=null) {
			bookmarkVO result = dao.selectBookmark(b);
			return result;
		} else {
			return null;
		}
	}
	
	@Override
	public int updateBookmark(int user_no, String bookmark_no) throws Exception {
		bookmarkVO b = new bookmarkVO();
		b.setUser_no(user_no);
		b.setBookmark_no(bookmark_no);
		
		int result = dao.updateBookmark(b);
		
		return result;
	}
	
	@Override
	public int insertBookmark(int user_no, String plusBN) throws Exception {
		bookmarkVO b = new bookmarkVO();
		b.setUser_no(user_no);
		b.setBookmark_no(plusBN);
		
		int result = dao.insertBookmark(b);
		
		return result;
	}
	
	@Override
	public ciVO loadBC(int bookmark_no)  throws Exception {
		if(dao.loadBC(bookmark_no) != null) {
			return dao.loadBC(bookmark_no);
		}
		return null;
	}
	
	@Override
	public List<ciVO> lac() throws Exception{
		if(dao.lac() != null) {
			return dao.lac();
		}
		return null;
	}

	@Override
	public List<ciVO> lc(String spirits) throws Exception{
		
		int s = Integer.parseInt(spirits);
		
		List<ingredientsVO> i = dao.loadSpiritIg(s);
		List<ciVO> result = new ArrayList<ciVO>();
		
		for(int j = 0; j < i.size(); j++) {
			List<ciVO> c = dao.selectRandomCocktailInfo(i.get(j).getIg());
			for(int k = 0; k < c.size(); k++) {
				result.add(c.get(k));
			}
		}
		
		System.out.println(result.get(0).getCocktail_name());
		
		return result;
	}
}
