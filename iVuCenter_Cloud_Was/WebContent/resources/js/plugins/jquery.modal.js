/*!
 * jQuery Modal
 * Copyright (c) 2015 CreativeDream
 * Website http://creativedream.net/plugins
 * Version: 1.2.3 (10-04-2015)
 * Requires: jQuery v1.7.1 or later
 */
function modal(e) {
	return $.cModal(e)
}(function(e) {
	e.cModal = function(t) {
		var n = {
				type: "default",
				title: null,
				text: null,
				size: "normal",
				buttons: [{
					text: "확인",
					val: true,
					onClick: function(e) {
						return true
					}
				}],
				center: true,
				autoclose: false,
				callback: null,
				onShow: null,
				animate: true,
				closeClick: false,
				closable: true,
				theme: "default",
				background: null,
				zIndex: 1050,
				buttonText: {
					ok: "확인",
					no: "아니오",
					yes: "확인",
					cancel: "취소"
				},
				//template: '<div class="modal-box"><div class="modal-inner"><div class="modal-title"><a class="modal-close-btn"></a></div><div class="modal-text"></div><div class="modal-buttons"></div></div></div>',
				template: '<div class="modal-box">'
							+'<div class="modal-inner">'
								+'<div class="modal-header">'
									+'<div class="modal-title" id="modalTitle">'
										//+'<a class="modal-close-btn"><img src="/resources/assets/img/btn_alert_close.png" alt="닫기"></a>'
										+'<a class="modal-close-btn"><i class="fa fa-close f26 mt-5"></i></a>'
									+'</div>'
								+'</div>'
								+'<div class="modal-body2">'
									+'<img src="/resources/assets/img/alert_picto.png" class="pictoImg">'
									+'<div class="modal-body-txt">'
									+'</div>'
								+'</div>'
								+'<div class="clear"></div>'
								+'<div class="alret-footer"></div>'
							+'</div>'
						+'</div>',
				_background : '<div class="modal-backdrop fade in" id="modalBackdrop"></div>',
				_classes: {
					box: ".modal-box",
					boxInner: ".modal-inner",
					title: "#modalTitle",
					content: ".modal-body-txt",
					buttons: ".alret-footer",
					closebtn: ".modal-close-btn"
				}
			},
			t = e.extend({}, n, t),
			r,i = e("<div id='modal-window' />").hide(),
			s = t._classes.box,
			o = i.append(t.template),
			u = {
				init: function() {
					e("#modal-window").remove();
					u._setStyle();
					u._modalShow();
					u._modalConent();
					i.on("click", "a.modal-btn", function(t) {
						u._modalBtn(e(this))
					}).on("click", t._classes.closebtn, function(e) {
						r = false;
						u._modalHide()
					}).click(function(e) {
						if (t.closeClick) {
							if (e.target.id == "modal-window") {
                                r = false;
								u._modalHide()
							}
						}
					});
					e(window).bind("keyup", u._keyUpF).resize(function() {
						var e = t.animate;
						t.animate = false;
						u._position();
						t.animate = e
					})
				},
				_setStyle: function() {
					i.css({
						position: "fixed",
						width: "100%",
						height: "100%",
						top: "0",
						left: "0",
						"z-index": t.zIndex,
						overflow: "auto"
					});
					i.find(t._classes.box).css({
						position: "absolute"
					});
				},
				_keyUpF: function(e) {
					switch (e.keyCode) {
						case 13:
							if (o.find("input:not(.modal-prompt-input),textarea").is(":focus")) {
								return false
							}
							u._modalBtn(i.find(t._classes.buttons + " a.modal-btn" + (typeof u.btnForEKey !== "undefined" && i.find(t._classes.buttons + " a.modal-btn:eq(" + u.btnForEKey + ")").size() > 0 ? ":eq(" + u.btnForEKey + ")" : ":last-child")));
							break;
						case 27:
							u._modalHide();
							break
					}
				},
				_modalShow: function() {
					e("body").css({
						width: e("body").innerWidth()
					}).append(o);
					e("#modalBackdrop").remove();
					e("body").append(t._background);
				},
				_modalHide: function(n) {
					e("#modalBackdrop").remove();

					if (t.closable === false) {
						return false
					}
					r = typeof r == "undefined" ? false : r;
					var o = function() {
						if ( t.callback != null && typeof(t.callback) == "function" ? (t.callback(r, i, u.actions) == false ? false : true) : true) {
							i.fadeOut(200, function() {
								e(this).remove();
								e("body").css({
									overflow: "",
									width: ""
								})
							});
							var n = 100 * parseFloat(e(s).css("top")) / parseFloat(e(s).parent().css("height"));
							e(s).stop(true, true).animate({
								top: n + (t.animate ? 3 : 0) + "%"
							}, "fast")
						}
					};
					if (!n) {
						o()
					} else {
						setTimeout(function() {
							o()
						}, n)
					}
					e(window).unbind("keyup", u._keyUpF)
				},
				_modalConent: function() {
					var n = t._classes.title,
						r = t._classes.content,
						o = t._classes.buttons,
						a = t.buttonText,
						f = ["prompt"],
						l = ["xenon", "atlant", "reseted"];
					if (e.inArray(t.type, f) == -1 && t.type != "default") {
						e(s).addClass("modal-type-" + t.type)
					}
					if (t.size && t.size != null) {
						e(s).addClass("modal-size-" + t.size)
					} else {
						e(s).addClass("modal-size-normal")
					}
					if (t.theme && t.theme != null && t.theme != "default") {
						e(s).addClass((e.inArray(t.theme, l) == -1 ? "" : "modal-theme-") + t.theme)
					}
					if (t.background && t.background != null) {
						i.css("background-color", t.background)
					}
					if (t.title || t.title != null) {
						e(n).prepend(t.title)
					} else {
						e(n).remove()
					}
					t.type == "prompt" ? t.text = (t.text != null ? t.text : "") + '<input type="text" name="modal-prompt-input" class="modal-prompt-input" autocomplete="off" autofocus="on" />' : "";
					e(r).html(t.text);
					if (t.buttons || t.buttons != null) {
						var c = "";
						switch (t.type) {
							case "alert":
								//c = '<a class="modal-btn' + (t.buttons[0].addClass ? " " + t.buttons[0].addClass : "") + '">' + a.ok + "</a>";
								c = '<a type=button class="whiteline modal-btn ' + (t.buttons[0].addClass ? " " + t.buttons[0].addClass : "") + 'btn-light-blue" >' + a.ok + '</a>';
								break;
							case "confirm":
								if(t.custom == "1"){
									c = '<a type=button class="modal-btn lbtn ' + (t.buttons[1] && t.buttons[1].addClass ? " " + t.buttons[1].addClass : "btn-light-blue") + '">' + a.yes + "</a>"
									+'<a type=button class="modal-btn lbtn ' + (t.buttons[1] && t.buttons[1].addClass ? " " + t.buttons[1].addClass : "btn-light-blue") + '" style="margin-left:10px;">' + a.no + "</a>"
								}else {
									c = '<a type=button class="modal-btn lbtn ' + (t.buttons[1] && t.buttons[1].addClass ? " " + t.buttons[1].addClass : "btn-light-blue") + '">' + a.yes + "</a>"
										+'<a type=button class="modal-btn lbtn ' + (t.buttons[0].addClass ? " " + t.buttons[0].addClass : "") + 'btn-light-blue" style="margin-left:10px;">' + a.cancel + '</a>';
								}
								break;
							case "prompt":
								c = '<a type=button class="modal-btn' + (t.buttons[0].addClass ? " " + t.buttons[0].addClass : "") + '">' + a.cancel + '</a><a class="modal-btn ' + (t.buttons[1] && t.buttons[1].addClass ? " " + t.buttons[1].addClass : "btn-light-blue") + '">' + a.ok + "</a>";
								break;
							case "confirm4":
								c = '<a type=button class="modal-btn lbtn ' + (t.buttons[1] && t.buttons[1].addClass ? " " + t.buttons[1].addClass : "btn-light-blue") + '">' + a.yes + "</a>"
								+'<a type=button class="modal-btn lbtn ' + (t.buttons[0].addClass ? " " + t.buttons[0].addClass : "") + 'btn-light-blue" style="margin-left:10px;">' + a.cancel + '</a>';
								break;
							default:
								if (t.buttons.length > 0 && e.isArray(t.buttons)) {
									e.each(t.buttons, function(e, t) {
										var n = t["addClass"] && typeof t["addClass"] != "undefined" ? " " + t["addClass"] : "";
										c += '<a class="modal-btn' + n + '">' + t["text"] + "</a>";
										if (t["eKey"]) {
											u.btnForEKey = e
										}
									})
								} else {
									c += '<a class="modal-btn">' + a.ok + "</a>"
								}
						}
						e(o).html(c)
					} else {
						e(o).remove()
					}
					if (t.type == "prompt") {
						$(".modal-prompt-input").focus()
					}
					if (t.autoclose) {
						var h = t.buttons || t.buttons != null ? e(r).text().length * 32 : 900;
						u._modalHide(h < 900 ? 900 : h)
					}
					i.fadeIn(200, function(){
                        t.onShow != null ? t.onShow(u.actions) : null;
                    });
					u._position();
				},
				_position: function() {
					var n, r, i;
					if (t.center) {
						n = {
							top: e(window).height() < e(s).outerHeight() ? 1 : 50,
							left: 50,
							marginTop: e(window).height() < e(s).outerHeight() ? 0 : -e(s).outerHeight() / 2,
							marginLeft: -e(s).outerWidth() / 2
						}, r = {
							top: n.top - (t.animate ? 3 : 0) + "%",
							left: n.left + "%",
							"margin-top": n.marginTop,
							"margin-left": n.marginLeft
						}, i = {
							top: n.top + "%"
						};
					} else {
						n = {
							top: e(window).height() < e(s).outerHeight() ? 1 : 10,
							left: 50,
							marginTop: 0,
							marginLeft: -e(s).outerWidth() / 2
						}, r = {
							top: n.top - (t.animate ? 3 : 0) + "%",
							left: n.left + "%",
							"margin-top": n.marginTop,
							"margin-left": n.marginLeft
						}, i = {
							top: n.top + "%"
						};
					}
					e(s).css(r).stop(true, true).animate(i, "fast")
				},
				_modalBtn: function(n) {
					var s = false,
						o = t.type,
						a = n.index(),
						f = t.buttons[a];
					var btnText = n.text();

					if (e.inArray(o, ["alert", "confirm","confirm4", "prompt"]) > -1) {
						//r = s = a == 1 ? true : false;
						r = s = a == 0 ? true : false;

						if(btnText === "아니오"){
							r = "second";
						}
						//r = s = n.context.innerText != "취소"? true : false;
						if (o == "prompt") {
							r = s = s && i.find("input.modal-prompt-input").size() > 0 != 0 ? i.find("input.modal-prompt-input").val() : false
						}
						u._modalHide()
					} else {
						if (n.hasClass("btn-disabled")) {
							return false
						}
						r = s = f && f["val"] ? f["val"] : true;
						if (!f["onClick"] || f["onClick"](e.extend({
								val: s,
								bObj: n,
								bOpts: f
							}, u.actions))) {
							u._modalHide()
						}
					}
					r = s
				},
				actions: {
					html: i,
					close: function() {
						u._modalHide()
					},
					getModal: function() {
						return i
					},
					getBox: function() {
						return i.find(t._classes.box)
					},
					getInner: function() {
						return i.find(t._classes.boxInner)
					},
					getTitle: function() {
						return i.find(t._classes.title)
					},
					getContet: function() {
						return i.find(t._classes.content)
					},
					getButtons: function() {
						return i.find(t._classes.buttons).find("a")
					},
					setTitle: function(e) {
						i.find(t._classes.title + " h3").html(e);
						return i.find(t._classes.title + " h3").size() > 0
					},
					setContent: function(e) {
						i.find(t._classes.content).html(e);
						return i.find(t._classes.content).size() > 0
					}
				}
			};
		u.init();
		return u.actions;
	}
})(jQuery);
