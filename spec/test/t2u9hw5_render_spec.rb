require 'spec_helper'

describe Codeforces::Viewer::Render do
  before do
    @render = Codeforces::Viewer::Render.new
  end

  context :render_html do
    context :sup do
      it "<sup>" do
        expect(@render.render_html("x<sup>y</sup>")).to eq "x^y"
      end
      it "<sup class>" do
        expect(@render.render_html("x<sup class>y</sup>")).to eq "x^y"
      end
      it "<sup><sup>" do
        expect(@render.render_html("x<sup>y</sup><sup>z</sup>")).to eq "x^y^z"
      end
    end

    context :sub do
      it "<sub>" do
        expect(@render.render_html("A<sub>i</sub>")).to eq "A[i]"
      end
      it "<sub class>" do
        expect(@render.render_html("A<sub class>i</sub>")).to eq "A[i]"
      end
      it "span sub" do
        html = '<span class="tex-span">1 ≤ <i>a</i><sub class="lower-index"><i>i</i></sub> ≤ 100</span>'
        expect(@render.render_html(html)).to include "1 ≤ a[i] ≤ 100"
      end
    end

    context :div do
      it "<div>" do
        expect(@render.render_html("A<div>B</div>C")).to eq "A\nB\nC"
      end
      it "<div class>" do
        expect(@render.render_html("A<div>B</div>C")).to eq "A\nB\nC"
      end
    end

    context :p do
      it "<p>" do
        expect(@render.render_html("A<p>B</p>C")).to eq "A\n\nB\n\nC"
      end
      it "<p class>" do
        expect(@render.render_html("A<p class>B</p>C")).to eq "A\n\nB\n\nC"
      end
    end

    context :list do
      it "<ol>" do
        expect(@render.render_html("<ol><li>1</li><li>2</li><li>3</li></ol>")).to eq "  1. 1\n  2. 2\n  3. 3\n\n"
      end
    end
  end
end
