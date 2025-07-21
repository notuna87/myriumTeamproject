const termsData = [
  {
    text: "이용약관에 동의합니다. (필수)",
    required: true,
    link: ctx + "/terms/detail?id=1"
  },
  {
    text: "개인정보처리방침에 동의합니다. (필수)",
    required: true,
    link: ctx + "/terms/detail?id=2"
  },
  {
    text: "개인정보 제3자 제공 동의 (선택)",
    required: false,
    link: ctx + "/terms/detail?id=3"
  },
  {
    text: "개인정보 처리 위탁 동의 (선택)",
    required: false,
    link: ctx + "/terms/detail?id=4"
  },
  {
    text: "SMS 수신 동의 (선택)",
    required: false,
    link: ctx + "/terms/detail?id=5"
  }
];
  
  const termsList = document.getElementById("termsList");
  
  termsData.forEach(term => {
    const li = document.createElement("li");
    li.innerHTML = `
      <div class="terms_item">
        <label>
          <input type="checkbox" class="term_chk" data-required="${term.required}" />
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
  
  // 전체 동의 제어
  const checkAll = document.getElementById("check_all");
  
  checkAll.addEventListener("change", function () {
    document.querySelectorAll(".term_chk").forEach(chk => {
      chk.checked = this.checked;
    });
  });
  
  // 개별 선택 체크시 전체 동의 체크 상태 갱신
  document.addEventListener("change", function () {
    const allTerms = document.querySelectorAll(".term_chk");
    const checkedTerms = document.querySelectorAll(".term_chk:checked");
    checkAll.checked = allTerms.length === checkedTerms.length;
  });
  
  // 토글 버튼 제어
  document.addEventListener("click", function (e) {
    if (e.target.classList.contains("toggle_btn")) {
      const detailDiv = e.target.closest("li").querySelector(".terms_detail");
      const isOpen = detailDiv.style.display === "block";
      detailDiv.style.display = isOpen ? "none" : "block";
      e.target.textContent = isOpen ? "⌄" : "^";
    }
  });
  

  const pwInput = document.getElementById("pw");
  const pwTooltip = document.getElementById("pw_tooltip");

  pwInput.addEventListener("focus", () => {
    pwTooltip.style.display = "block";
  });

  pwInput.addEventListener("blur", () => {
    pwTooltip.style.display = "none";
  });
