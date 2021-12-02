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

public interface dao {
  int selectUser(String paramString) throws Exception;
  
  int signUp(userVO paramuserVO) throws Exception;
  
  userVO selectUserInfo(userVO paramuserVO) throws Exception;
  
  List<ciVO> selectRandomCocktailInfo(int spirit) throws Exception;
  
  ciVO selectCocktail(String paramString) throws Exception;
  
  List<ciVO> searchCocktail(String paramString) throws Exception;
  
  boolean modifyInfo(String paramString1, String paramString2, String paramString3) throws Exception;
  
  List<ingredientsVO> ingredientsList() throws Exception;
  
  int maxNo() throws Exception;
  
  int addRefrige(int paramInt1, int paramInt2) throws Exception;
  
  int updateRefrige(int paramInt1, int paramInt2, int paramInt3) throws Exception;
  
  refrigeratorVO selectRefrige(int paramInt) throws Exception;
  
  int deleteRefrige(refrigeratorVO paramrefrigeratorVO) throws Exception;
  
  List<ingredientsVO> searchIg(String paramString) throws Exception;
  
  List<ciVO> fitCocktail(int paramInt) throws Exception;
  
  ciVO selectIg(int paramInt) throws Exception;
  
  int requiredIg(refrigeratorVO paramrefrigeratorVO) throws Exception;
  
  int addBoard(boardVO paramboardVO) throws Exception;
  
  int addAttach(attachVO paramattachVO) throws Exception;
  
  int maxNoBoard() throws Exception;
  
  int maxNoAttach() throws Exception;
  
  List<boardVO> loadBoardList(int paramInt) throws Exception;
  
  List<boardVO> loadBoardList2(String word, int paramInt) throws Exception;
  
  List<boardVO> loadBoardList3(int paramInt, String user_id) throws Exception;
  
  int selectView(boardVO paramboardVO) throws Exception;
  
  boardVO loadBoard(boardVO paramboardVO) throws Exception;
  
  int updateView(boardVO paramboardVO) throws Exception;
  
  List<attachVO> loadAttach(attachVO paramattachVO) throws Exception;
  
  int deleteAttach(attachVO paramattachVO) throws Exception;
  
  int deleteBoard(boardVO paramboardVO) throws Exception;
  
  int modifySave(boardVO paramboardVO) throws Exception;
  
  List<replyVO> loadReply(replyVO paramreplyVO) throws Exception;
  
  int saveReply(replyVO paramreplyVO) throws Exception;
  
  int maxReplyNo() throws Exception;
  
  int deleteReply1(replyVO paramreplyVO) throws Exception;
  
  int deleteReply2(replyVO paramreplyVO) throws Exception;

  bookmarkVO selectBookmark(bookmarkVO b);

  int updateBookmark(bookmarkVO b);

  int insertBookmark(bookmarkVO b);
  
  ciVO loadBC(int bookmark_no);
  
  List<ingredientsVO> loadSpiritIg(int spirit);
  
  List<ciVO> lac() throws Exception;
}
