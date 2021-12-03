package com.hallym.service;

import com.hallym.vo.attachVO;
import com.hallym.vo.boardVO;
import com.hallym.vo.bookmarkVO;
import com.hallym.vo.ciVO;
import com.hallym.vo.ingredientsVO;
import com.hallym.vo.refrigeratorVO;
import com.hallym.vo.replyVO;
import com.hallym.vo.userVO;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public interface service {
  int signUp(userVO paramuserVO) throws Exception;
  
  userVO signIn(userVO paramuserVO) throws Exception;
  
  List<ciVO> selectRandomCocktailInfo() throws Exception;
  
  ciVO selectCocktail(String paramString) throws Exception;
  
  List<ciVO> searchCocktail(String paramString) throws Exception;
  
  boolean modifyInfo(String paramString1, String paramString2, String paramString3) throws Exception;
  
  List<ingredientsVO> ingredientsList() throws Exception;
  
  int addRefrige(int paramInt1, int paramInt2) throws Exception;
  
  refrigeratorVO loadRefrige(int paramInt) throws Exception;
  
  int deleteRefri(refrigeratorVO paramrefrigeratorVO) throws Exception;
  
  List<ingredientsVO> searchIg(String paramString) throws Exception;
  
  List<ciVO> fitCocktail(int paramInt) throws Exception;
  
  int requiredIg(refrigeratorVO paramrefrigeratorVO) throws Exception;
  
  int addBoard(boardVO paramboardVO) throws Exception;
  
  int addAttach(attachVO paramattachVO) throws Exception;
  
  List<boardVO> loadBoardList(int paramInt) throws Exception;
  
  List<boardVO> loadBoardList(String word, int paramInt) throws Exception;
  
  List<boardVO> loadBoardList(int page, String user_id) throws Exception;
  
  boardVO loadBoard(int paramInt) throws Exception;
  
  List<attachVO> loadAttach(attachVO paramattachVO) throws Exception;
  
  int deleteAttach(attachVO paramattachVO) throws Exception;
  
  int deleteBoard(boardVO paramboardVO) throws Exception;
  
  int modifySave(boardVO paramboardVO) throws Exception;
  
  List<replyVO> loadReply(replyVO paramreplyVO) throws Exception;
  
  int saveReply(replyVO paramreplyVO) throws Exception;
  
  int deleteReply(replyVO paramreplyVO) throws Exception;

  bookmarkVO selectBookmark(int user_no) throws Exception;

  int updateBookmark(int user_no, String bookmark_no) throws Exception;

  int insertBookmark(int user_no, String plusBN) throws Exception;
  
  ciVO loadBC(int bookmark_no) throws Exception;
  
  List<ciVO> lac() throws Exception;
  
  List<ciVO> lc(String spirits) throws Exception;
  
  int getout(int user_no, String user_id) throws Exception;
}
