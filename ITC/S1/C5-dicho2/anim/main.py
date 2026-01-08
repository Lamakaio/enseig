from manim import *

class ManimCELogo(Scene):
    def construct(self):
        L1 = []
        L2 = []
        for x in [1, 2, 4, 8, 12, 32, 42]:
            sq = Square(color=BLUE, fill_opacity=0.7, stroke_opacity=0.7)
            text = Text(str(x), stroke_width=1)
            group = VGroup(sq, text).scale(0.2).move_to(LEFT*5).shift(UP*2)
            if len(L1)>0:
                group.next_to(L1[-1], RIGHT)
            L1.append(group)
            self.add(group)

        for x in [0, 3, 5, 6, 15, 40, 41]:
            sq = Square(color=RED, fill_opacity=0.7, stroke_opacity=0.7)
            text = Text(str(x), stroke_width=1)
            group = VGroup(sq, text).scale(0.2).move_to(LEFT*5).shift(DOWN*2)
            if len(L2)>0:
                group.next_to(L2[-1], RIGHT)
            L2.append(group)
            self.add(group)
        circle = Circle().scale(0.3) 
        circle.move_to(L2[0])
        self.play(Create(circle))
        self.remove(circle)
        self.play(L2[0].animate.move_to(LEFT * 3))
        
        circle.move_to(L1[0])
        self.play(Create(circle))
        self.remove(circle)

        self.play(L1[0].animate.next_to(L2[0]))

        circle.move_to(L1[1])
        self.play(Create(circle))
        self.remove(circle)

        self.play(L1[1].animate.next_to(L1[0]))

        circle.move_to(L2[1])
        self.play(Create(circle))
        self.remove(circle)

        self.play(L2[1].animate.next_to(L1[1]))

        circle.move_to(L1[2])
        self.play(Create(circle))
        self.remove(circle)

        self.play(L1[2].animate.next_to(L2[1]))
        self.play(L2[2].animate.next_to(L1[2]))
        self.play(L2[3].animate.next_to(L2[2]))
        self.play(L1[3].animate.next_to(L2[3]))
        self.play(L1[4].animate.next_to(L1[3]))
        self.play(L2[4].animate.next_to(L1[4]))
        self.play(L1[5].animate.next_to(L2[4]))
        self.play(L2[5].animate.next_to(L1[5]))
        self.play(L2[6].animate.next_to(L2[5]))
        self.play(L1[6].animate.next_to(L2[6]))