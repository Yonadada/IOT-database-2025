# 파이썬 웹앱(Flask)

# 플라스크를 이용해서 DB에 있는 데이터를 웹에서도 불러올 수 있다는 것을 보여주는 예제
## 1. Flask 라이브러리 설치
# pip install Flask -> 파워쉘에 
##--------
# 2. Flask 및 관련 라이브러리 임포트
from flask import Flask, render_template, request
import pymysql
##--------
# 3.데이터베이스 연결을 위한 변수초기화
host = 'localhost' # or '127.0.0.1'
port = 3306
database = 'madang'
username = 'root'
password = '12345'
##--------
## 4.데이터베이스 접속 상태 플래그
conflag = True # 접속상태

## 5.Flask 애플리케이션 객체 생성
app = Flask(__name__) # 플라스크 웹앱 실행 구문


## 6. MySQL 데이터베이스 연결
conn = pymysql.connect(host=host, user=username, password=password, port=port, database=database)
cursor = conn.cursor()


## 7. 기본 페이지 라우팅
@app.route('/') # routing decorator : 웹 사이트 경로를 실행할 때 http://localhost:5000/
def index():
    ## 8. 데이터베이스에서 책 목록 조회
    query = '''SELECT bookid
                    , bookname
                    , publisher
                    , price 
                FROM Book'''  
    ## 9.쿼리 실행 및 결과 가져오기            
    res = cursor.execute(query) # SQL 쿼리 실행
    data = cursor.fetchall()    # 모든 결과를 가져옴
    
    ## 10. HTML 템플릿 렌더링 
    # templates 폴더에 있는 html을 데이터와 연결해서 렌더링 함.
    return render_template('booklist.html', book_list = data)

## 11.책 상세 정보 페이지 라우팅 
@app.route('/view')  #/view 경로에 접속하면 실행되는 함수
def getDetail(): # http://localhost:5000/view?id=2  처럼 id 값을 URL 파라미터로 전달하면 해당 책의 정보를 보여줌
    
    ## 12.요청에서 id 값 가져오기
    bookid = request.args.get('id')
    ## 13.특정 책 정보를 조회하는 SQL문 생성
    query = f'''SELECT bookid
                    , bookname
                    , publisher
                    , price 
                FROM Book
                WHERE bookid = '{bookid}'
                '''  
    ## SQL 실행 및 데이터 가져오기            
    cursor.execute(query) 
    data = cursor.fetchall()
    
    ## 15.HTML 템플릿 렌더링(책 상세 정보 페이지)
    return render_template('bookview.html', book = data) #bookview.html 렌더링하면서 book 데이터 전달

## 16.Flask 애플리케이션 실행
if __name__ == '__main__':
    app.run('localhost') 
# 이 파일이 직접 실행될 때 Flask 애플리케이션을 실행, localhost에서 실행됨(기본 포트: 5000)
