

//아이디 유효성 검사 

let isIdAvailable = false; // 전역 변수로 사용 가능 여부 저장

document.getElementById('userid').addEventListener('input', function () {
  const id = this.value;
  const errorEl = document.getElementById('idError');

  const basicRule = /^[a-z0-9]{4,16}$/;
  const startsWithNumber = /^[0-9]/.test(id);
  const onlyNumbers = /^[0-9]+$/.test(id);
  const containsUpperCase = /[A-Z]/.test(id);
  const containsSpecialOrSpace = /[^a-zA-Z0-9]/.test(id);
  const containsKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(id);

  // 초기화
  errorEl.textContent = '';
  errorEl.className = '';
  isIdAvailable = false;

  if (!id) return;

  if (
    containsUpperCase ||
    containsSpecialOrSpace ||
    startsWithNumber ||
    onlyNumbers ||
    containsKorean
  ) {
    errorEl.textContent = '대문자/공백/특수문자가 포함되었거나, 숫자로 시작 또는 숫자로만 이루어진 아이디는 사용할 수 없습니다.';
    errorEl.className = 'error_msg';
    return;
  }

  if (!basicRule.test(id)) {
    errorEl.textContent = '아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요.';
    errorEl.className = 'error_msg';
    return;
  }

  // ✅ 아이디 중복 확인 API 호출
	fetch(`/member/check-id?customerId=${id}`)
	  .then(response => response.text())
	  .then(text => {
	    if (text === "unavailable") {
	      errorEl.textContent = '이미 사용 중인 아이디입니다.';
	      errorEl.className = 'error_msg';
	      isIdAvailable = false;
	    } else {
	      errorEl.textContent = '사용 가능한 아이디입니다.';
	      errorEl.className = 'success_msg';
	      isIdAvailable = true;
	    }
	  })
	  .catch(() => {
	    errorEl.textContent = '서버 오류로 확인할 수 없습니다.';
	    errorEl.className = 'error_msg';
	    isIdAvailable = false;
	  });
});


//비밀번호 유효성 검사

const pwInput = document.getElementById('pw');
const pw2Input = document.getElementById('pw2');
const idInput = document.getElementById('userid');
const pwErrorEl = document.getElementById('pwError');
const pwMatchErrorEl = document.getElementById('pwMatchError');
const pwTooltip = document.getElementById('pw_tooltip');

// tooltip 이벤트
pwInput.addEventListener("focus", () => {
  pwTooltip.style.display = "block";
});
pwInput.addEventListener("blur", () => {
  pwTooltip.style.display = "none";
});

// 유효성 검사 이벤트
pwInput.addEventListener('input', validatePassword);
pw2Input.addEventListener('input', checkPasswordMatch);
idInput.addEventListener('input', validatePassword); // 아이디 변경 시 재검사

function validatePassword() {
  const pw = pwInput.value;
  const id = idInput.value;

  const lengthValid = pw.length >= 10 && pw.length <= 16;
  const hasUpper = /[A-Z]/.test(pw);
  const hasLower = /[a-z]/.test(pw);
  const hasNumber = /[0-9]/.test(pw);
  const hasSpecial = /[~!@#$%^&*()\-=+\[\]{}<>?]/.test(pw); // [] 특수문자 이스케이프 처리
  const hasSpace = /\s/.test(pw);
  const repeatedChars = /(.)\1\1/.test(pw);
  const containsId = id && pw.includes(id);

  let categoryCount = 0;
  if (hasUpper) categoryCount++;
  if (hasLower) categoryCount++;
  if (hasNumber) categoryCount++;
  if (hasSpecial) categoryCount++;

  if (!pw) {
    pwErrorEl.textContent = '';
    pwErrorEl.className = '';
  } else if (!lengthValid) {
    setError(pwErrorEl, '비밀번호는 10자 이상 16자 이하로 입력해 주세요.');
  } else if (hasSpace) {
    setError(pwErrorEl, '공백은 사용할 수 없습니다.');
  } else if (categoryCount < 2) {
    setError(pwErrorEl, '대소문자/숫자/특수문자 중 2가지 이상 조합해야 합니다.');
  } else if (repeatedChars) {
    setError(pwErrorEl, '동일한 문자를 반복해서 사용할 수 없습니다.');
  } else if (containsId) {
    setError(pwErrorEl, '아이디를 포함할 수 없습니다.');
  } else {
    setSuccess(pwErrorEl, '사용 가능한 비밀번호입니다.');
  }

  checkPasswordMatch();
}

function checkPasswordMatch() {
  const pw = pwInput.value;
  const pw2 = pw2Input.value;

  if (!pw2) {
    pwMatchErrorEl.textContent = '';
    pwMatchErrorEl.className = '';
  } else if (pw !== pw2) {
    setError(pwMatchErrorEl, '입력한 비밀번호와 일치하지 않습니다.');
  } else {
    setSuccess(pwMatchErrorEl, '비밀번호가 일치합니다.');
  }
}

function setError(el, msg) {
  el.textContent = msg;
  el.className = 'error_msg';
}

function setSuccess(el, msg) {
  el.textContent = msg;
  el.className = 'success_msg';
}


//주소api
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 선택된 주소 정보로 input 채우기
            document.getElementById('postcode').value = data.zonecode; // 우편번호
            document.getElementById('roadAddress').value = data.roadAddress; // 도로명주소
            document.getElementById('detailAddress').focus(); // 포커스를 상세주소로 이동
        }
    }).open();
}


  
//인정번호받기
document.getElementById("sendCodeBtn").addEventListener("click", function () {
  const confirmMsg = document.getElementById("phoneConfirmMsg");
  confirmMsg.style.display = "block";
});

//이메일 유효성검사

const emailInput = document.getElementById('email');
const emailErrorEl = document.getElementById('emailError');

emailInput.addEventListener('input', () => {
  const email = emailInput.value;
  const emailRule = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

  if (!email) {
    emailErrorEl.textContent = '';
    emailErrorEl.className = '';
  } else if (!emailRule.test(email)) {
    emailErrorEl.textContent = '올바른 이메일 주소 형식이 아닙니다.';
    emailErrorEl.className = 'error_msg';
  } else {
    emailErrorEl.textContent = '사용 가능한 이메일입니다.';
    emailErrorEl.className = 'success_msg';
  }
});


// 약관 항목 데이터 (name 명시)
const termsData = [
  {
    name: "agreeTerms",
    text: "이용약관에 동의합니다. (필수)",
    required: true,
    link: ctx + "/terms/detail?id=1"
  },
  {
    name: "agreePrivacy",
    text: "개인정보처리방침에 동의합니다. (필수)",
    required: true,
    link: ctx + "/terms/detail?id=2"
  },
  {
    name: "agreeThirdParty",
    text: "개인정보 제3자 제공 동의 (선택)",
    required: false,
    link: ctx + "/terms/detail?id=3"
  },
  {
    name: "agreeDelegate",
    text: "개인정보 처리 위탁 동의 (선택)",
    required: false,
    link: ctx + "/terms/detail?id=4"
  },
  {
    name: "agreeSms",
    text: "SMS 수신 동의 (선택)",
    required: false,
    link: ctx + "/terms/detail?id=5"
  }
];

// 약관 영역 렌더링
const termsList = document.getElementById("termsList");

termsData.forEach(term => {
  const li = document.createElement("li");
  li.innerHTML = `
    <div class="terms_item">
      <label>
        <input 
          type="checkbox" 
          class="term_chk"
          name="${term.name}"
          value="1"
          data-required="${term.required}" />
        ${term.text}
      </label>
      <button type="button" class="toggle_btn">⌄</button>
    </div>
    <div class="terms_detail" style="display:none; margin-left: 20px;">
      <a href="${term.link}" class="terms_link" target="_blank">약관내용 확인하기</a>
    </div>
  `;
  termsList.appendChild(li);
});

// 전체 동의 체크 시 모든 항목 체크
const checkAll = document.getElementById("check_all");

checkAll.addEventListener("change", function () {
  document.querySelectorAll(".term_chk").forEach(chk => {
    chk.checked = this.checked;
  });
});

// 개별 항목 체크 시 전체 동의 상태 갱신
document.addEventListener("change", function () {
  const allTerms = document.querySelectorAll(".term_chk");
  const checkedTerms = document.querySelectorAll(".term_chk:checked");
  checkAll.checked = allTerms.length === checkedTerms.length;
});

// 토글 버튼 클릭 시 약관 내용 열기/닫기
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("toggle_btn")) {
    const detailDiv = e.target.closest("li").querySelector(".terms_detail");
    const isOpen = detailDiv.style.display === "block";
    detailDiv.style.display = isOpen ? "none" : "block";
    e.target.textContent = isOpen ? "⌄" : "^";
  }
});


  
 //회원가입 버튼 전체 유효성검사 
 document.getElementById("submitBtn").addEventListener("click", function (e) {
  e.preventDefault(); // 기본 제출 막음

  const errors = [];

  // 1. 아이디
  const idError = document.getElementById("idError");
  const idVal = document.getElementById("userid").value;
  if (!idVal || idError.className === "error_msg" || !isIdAvailable) {
    errors.push("아이디 형식이 올바르지 않거나 이미 사용 중인 아이디입니다.");
  }

  // 2. 비밀번호
  const pwError = document.getElementById("pwError");
  const pwVal = document.getElementById("pw").value;
  if (!pwVal || pwError.className === "error_msg") {
    errors.push("비밀번호 형식이 올바르지 않거나 입력되지 않았습니다.");
  }

  // 3. 비밀번호 확인
  const pw2Val = document.getElementById("pw2").value;
  const pwMatchError = document.getElementById("pwMatchError");
  if (!pw2Val || pwMatchError.className === "error_msg") {
    errors.push("비밀번호 확인이 올바르지 않습니다.");
  }

  // 4. 이름
  const nameVal = document.getElementById("name").value;
  if (!nameVal) {
    errors.push("이름을 입력해주세요.");
  }

  // 5. 주소
  const postcode = document.getElementById("postcode").value;
  const roadAddress = document.getElementById("roadAddress").value;
  const detailAddress = document.getElementById("detailAddress").value;
  if (!postcode || !roadAddress || !detailAddress) {
    errors.push("주소를 모두 입력해주세요.");
  }

  // 6. 휴대전화
  const phoneInputs = document.querySelectorAll(".phone_group input[type='text']");
  let phoneValid = true;
  phoneInputs.forEach((input) => {
    if (!input.value.trim()) phoneValid = false;
  });
  if (!phoneValid) {
    errors.push("휴대전화 번호를 모두 입력해주세요.");
  }

  // 7. 이메일
  const email = document.getElementById("email").value;
  const emailError = document.getElementById("emailError");
  if (!email || emailError.className === "error_msg") {
    errors.push("이메일 형식이 올바르지 않거나 입력되지 않았습니다.");
  }

  // 8. 성별
  const genderChecked = document.querySelector("input[name='gender']:checked");
  if (!genderChecked) {
    errors.push("성별을 선택해주세요.");
  }

  // 9. 필수 약관
  const requiredTerms = document.querySelectorAll(".term_chk[data-required='true']");
  const agreedTerms = Array.from(requiredTerms).filter(chk => chk.checked);
  if (agreedTerms.length < requiredTerms.length) {
    errors.push("필수 약관에 모두 동의해주세요.");
  }

  // 최하단 에러 메시지 1건만 팝업
  if (errors.length > 0) {
    alert(errors[errors.length - 1]);
  } else {
    document.querySelector("form").submit();
  }

});